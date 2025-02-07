import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:healer_user/model/profile_model/profile_model.dart';
import 'package:healer_user/model/signup_model/signup_model.dart';
import 'package:healer_user/model/signup_model/signup_response_model.dart';
import 'package:healer_user/services/token.dart';
import 'package:healer_user/services/user/user_id.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

Future<String?> _validateToken() async {
  final token = await getValidToken();
  if (token == null) log('Token is null or invalid');
  return token;
}

Future<http.Response?> makeRequest(
  String url,
  String method, {
  Map<String, String>? headers,
  dynamic body,
}) async {
  final token = await _validateToken();
  if (token == null) return null;

  headers = {
    ...?headers,
    'Authorization': 'Bearer $token',
    "Content-Type": "application/json"
  };

  switch (method) {
    case 'GET':
      return await http.get(Uri.parse(url), headers: headers);
    case 'POST':
      return await http.post(Uri.parse(url), headers: headers, body: body);
    case 'PUT':
      return await http.put(Uri.parse(url), headers: headers, body: body);
    case 'DELETE':
      return await http.delete(Uri.parse(url), headers: headers);
    default:
      log('Unsupported HTTP method: $method');
      return null;
  }
}

Future<bool> makeMultipartRequest({
  required String url,
  required String method,
  required SignupModel user,
  File? imageFile,
}) async {
  // final token = await _validateToken();
  // if (token == null) return false;

  try {
    final request = http.MultipartRequest(method, Uri.parse(url));
    request.fields.addAll({
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'gender': user.gender,
      'age': user.age.toString() ?? '0',
    });

    if (imageFile != null) {
      final fileBytes = await imageFile.readAsBytes();
      request.files.add(http.MultipartFile(
        'image',
        Stream.value(fileBytes),
        fileBytes.length,
        filename: imageFile.path.split('/').last,
        contentType: MediaType('image', imageFile.path.split('.').last),
      ));
    }

    // request.headers.addAll({'Authorization': 'Bearer $token'});
    final streamedResponse = await request.send();

    // Convert stream to string to get the response body
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      log('Response body: ${response.body}');
      final signupResponse =
          SignupResponseModel.fromJson(jsonDecode(response.body));
      log(signupResponse.isVerified.toString());

      if (signupResponse.isVerified == true && signupResponse.token != null) {
        await storeToken(signupResponse.token!);
        await storeUserId(signupResponse.userId);
      } else {
        log('Not verified');
      }
      return true;
    } else {
      log('SignUp failed with status: ${response.statusCode}, body: ${response.body}');
      return false;
    }
  } catch (e) {
    log('Error during request: $e');
    return false;
  }
}

Future<bool> makeEditMultipartRequest({
  required String url,
  required String method,
  required String name,
  required String gender,
  required int age,
  File? imageFile,
}) async {
  final token = await _validateToken();
  if (token == null) return false;

  try {
    final request = http.MultipartRequest(method, Uri.parse(url));
    request.fields.addAll({
      'name': name,
      'gender': gender,
      'age': age.toString() ?? '0',
    });

    if (imageFile != null) {
      final fileBytes = await imageFile.readAsBytes();
      request.files.add(http.MultipartFile(
        'image',
        Stream.value(fileBytes),
        fileBytes.length,
        filename: imageFile.path.split('/').last,
        contentType: MediaType('image', imageFile.path.split('.').last),
      ));
    }

    request.headers.addAll({'Authorization': 'Bearer $token'});
    final streamedResponse = await request.send();

    // Convert stream to string to get the response body
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201 || response.statusCode == 200) {
      log('Response body: ${response.body}');
    // final UserModel user = parseUserResponse(jsonDecode(response.body));
    
      return true;
    } else {
      log('Edit failed with status: ${response.statusCode}, body: ${response.body}');
      return false;
    }
  } catch (e) {
    log('Error during request: $e');
    return false;
  }
}

UserModel parseUserResponse(Map<String, dynamic> responseData) {
  // Extract the user data from the response
  final userData = responseData['user'];

  if (userData == null) {
    throw Exception("User data not found in the response");
  }

  // Add missing fields to match the UserModel structure
  userData['createdAt'] = userData['createdAt'] ?? DateTime.now().toIso8601String();
  userData['updatedAt'] = userData['updatedAt'] ?? DateTime.now().toIso8601String();

  // Map 'id' to '_id' for compatibility with the model
  userData['_id'] = userData['_id'] ?? userData['id'];

  // Add default value for '__v' if missing
  userData['__v'] = userData['__v'] ?? 0;

  // Return a properly parsed UserModel
  return UserModel.fromJson(userData);
}
