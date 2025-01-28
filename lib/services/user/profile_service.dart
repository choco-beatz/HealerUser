import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:healer_user/model/profile_model/profile_model.dart';
import 'package:healer_user/services/api_helper.dart';
import 'package:healer_user/services/endpoints.dart';

Future<UserModel?> getProfile() async {
  final response = await makeRequest(profileUrl, 'GET');
  if (response == null || response.statusCode != 200) return null;

  try {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    // log(data.toString());
    // Access the nested user object first
    final userData = data['user'] as Map<String, dynamic>;
    final userModel = UserModel.fromJson(userData);
    // log(userModel.email.toString());
    return userModel;
  } catch (e) {
    log('Error parsing user profile: $e');
    return null;
  }
}

Future<bool> editProfile({required String name,required int age, required String gender, File? image}) {
  return makeEditMultipartRequest(method: 'PUT',url: editProfileUrl,age: age, name: name, gender: gender, imageFile: image);
 }