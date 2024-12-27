// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'registeration_bloc.dart';

class RegisterationEvent {}

class SignUpEvent extends RegisterationEvent {
  SignupModel data;
  SignUpEvent({
    required this.data,
  });
}

class VerifyOTPEvent extends RegisterationEvent {
  String otp;
  String email;
  VerifyOTPEvent({
    required this.otp,
    required this.email,
  });
}

class ResentOTPEvent extends RegisterationEvent {
  String email;
  ResentOTPEvent({
    required this.email,
  });
}

class LoginEvent extends RegisterationEvent {
  LoginModel data;
  LoginEvent({
    required this.data,
  });
}

class CheckTokenEvent extends RegisterationEvent {}

class LogOutEvent extends RegisterationEvent {}