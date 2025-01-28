import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:healer_user/model/login_model/login_model.dart';
import 'package:healer_user/model/login_model/login_response_model.dart';
import 'package:healer_user/model/signup_model/signup_response_model.dart';
import 'package:healer_user/services/api_helper.dart';
import 'package:healer_user/services/endpoints.dart';
import 'package:healer_user/services/token.dart';
import 'package:healer_user/services/user/user_id.dart';
import 'package:http/http.dart' as http;
import 'package:healer_user/model/signup_model/signup_model.dart';

Future<bool> registeration(SignupModel user, File? imageFile) async {
  log('from service : ${user.name}');
  return makeMultipartRequest(
    url: registerationUrl,
    method: 'POST',
    user: user,
    imageFile: imageFile,
  );

}

Future<bool> veriftOtp(String otp, String email) async {
  try {
    final response = await http.post(Uri.parse(otpUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "otp": otp}));
    if (response.statusCode == 200) {
      final signupresponse =
          SignupResponseModel.fromJson(jsonDecode(response.body));
      await storeToken(signupresponse.token!);
      await storeUserId(signupresponse.userId);
      return true;
    } else {
      log(response.statusCode.toString());
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<bool> resentOtp(String email) async {
  try {
    final response = await http.post(Uri.parse(resentOtpUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}));
    if (response.statusCode == 200) {
      return true;
    } else {
      log(response.statusCode.toString());
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<String> login(LoginModel login) async {
  try {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": login.email,
        "password": login.password,
      }),
    );
    log(response.body);
    if (response.statusCode == 200) {
      final loginResponse =
          LoginResponseModel.fromJson(jsonDecode(response.body));
      if (loginResponse.isVerified == true && loginResponse.token != null) {
        await storeToken(loginResponse.token!);
        log('usreid${loginResponse.userId}');
        await storeUserId(loginResponse.userId);
        return 'isVerified';
      } else {
        return 'notVerified';
      }
    } else {
      log('Login failed with status: ${response.statusCode}');
      return '';
    }
  } catch (e) {
    log('Error during login: $e');
    return '';
  }
}
