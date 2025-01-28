import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:healer_user/model/login_model/login_model.dart';
import 'package:healer_user/model/signup_model/signup_model.dart';
import 'package:healer_user/services/token.dart';
import 'package:healer_user/services/user/registeration_service.dart';
import 'package:image_picker/image_picker.dart';

part 'registeration_event.dart';
part 'registeration_state.dart';

class RegisterationBloc extends Bloc<RegisterationEvent, RegisterationState> {
  late final StreamSubscription tokenCheck;
  final ImagePicker imagePicker = ImagePicker();

  RegisterationBloc() : super(RegisterationInitial()) {
    tokenCheck = Stream.periodic(
      const Duration(minutes: 15),
      (_) => CheckTokenEvent(),
    ).listen(
      (event) {
        add(event);
      },
    );
    on<SignUpEvent>((event, emit) async {
      bool success = await registeration(event.data, event.imageFile);
      if (success == true) {
        emit(RegisterationState(isSuccess: true));
      } else {
        emit(RegisterationState(isSuccess: false, message: 'failed'));
      }
    });

    on<VerifyOTPEvent>((event, emit) async {
      bool success = await veriftOtp(event.otp, event.email);

      if (success == true) {
        emit(RegisterationState(isSuccess: success, isVerified: true));
      } else {
        emit(RegisterationState(isSuccess: success, message: 'failed'));
      }
    });

    on<ResentOTPEvent>((event, emit) async {
      bool success = await resentOtp(event.email);

      if (success == true) {
        emit(RegisterationState(isSuccess: success, resentOtp: true));
      } else {
        emit(RegisterationState(isSuccess: success, message: 'failed'));
      }
    });

    on<LoginEvent>(
      (event, emit) async {
        String isVerified = await login(event.data);
        if (isVerified == 'isVerified') {
          emit(RegisterationState(isSuccess: true, isVerified: true));
        } else if (isVerified == 'notVerified') {
          emit(RegisterationState(
              isSuccess: false, isVerified: false, resentOtp: true));
        } else {
          emit(RegisterationState(isSuccess: false, hasError: true, message: 'failed'));
        }
      },
    );

    on<CheckTokenEvent>(((event, emit) async {
      log(state.tokenValid.toString());

      if (state.tokenValid && state.isInitalized) return;
      final token = await getValidToken();

      if (token == null || isExpired(token)) {
        emit(RegisterationState(
            hasError: true,
            tokenValid: false,
            redirect: true,
            isInitalized: false,
            message: '  Token expired!'));
      } else if (!isExpired(token)) {
        emit(RegisterationState(tokenValid: true, isInitalized: true));
      } else {
        emit(RegisterationState(
            hasError: true,
            redirect: true,
            tokenValid: false,
            isInitalized: false,
            message: '  Token expired!'));
      }
    }));

    on<LogOutEvent>((event, emit) async {
      emit(RegisterationState());

      try {
        await clearToken();
        emit(RegisterationState(
          redirect: true,
          message: 'Logout successful!',
        ));
      } catch (e) {
        log('Logout failed: $e');

        emit(RegisterationState(
          hasError: true,
          message: 'Logout failed. Please try again.',
        ));
      }
    });

    on<PickImageEvent>((event, emit) async {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(RegisterationState(
          pickedImage: File(pickedFile.path),
          isInitalized: state.isInitalized,
        ));
      } else {
        emit(RegisterationState(
          isInitalized: state.isInitalized,
        ));
      }
    });
  }
}
