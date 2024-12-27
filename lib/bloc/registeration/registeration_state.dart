part of 'registeration_bloc.dart';

class RegisterationState {
  final bool tokenValid;
  final bool isVerified;
  final bool redirect;
  final bool hasError;
  final bool isInitalized;
  final bool isSuccess;
  final bool resentOtp;
  final String message;

  RegisterationState(
      {this.tokenValid = false,
      this.isVerified = false,
      this.redirect = false,
      this.isSuccess = false,
      this.hasError = false,
      this.isInitalized = false,
      this.resentOtp = false,
      this.message = ''});
}

final class RegisterationInitial extends RegisterationState {}
