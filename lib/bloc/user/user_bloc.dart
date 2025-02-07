import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:healer_user/model/profile_model/profile_model.dart';
import 'package:healer_user/services/user/profile_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = await getProfile();
        if (user != null) {
          log('User email: ${user.email}');
          emit(ProfileLoaded(user: user));
        } else {
          log('Failed to load user profile: null user.');
          emit(ProfileError(message: 'Failed to load profile.'));
        }
      } catch (e, stackTrace) {
        log('Error occurred while fetching profile: $e',
            stackTrace: stackTrace);
        emit(ProfileError(message: 'An error occurred: $e'));
      }
    });

   on<EditProfileEvent>((event, emit) async {
  emit(ProfileLoading()); 
  try {
    bool success = await editProfile(
      age: event.age,
      name: event.name,
      gender: event.gender,
      image: event.image,
    );

    if (success) {
      final user = await getProfile();
      if (user != null) {
        log('User email: ${user.email}');
        emit(ProfileLoaded(user: user)); 
      } else {
        log('Failed to load user profile: null user.');
        emit(ProfileError(message: 'Failed to load profile.'));
      }
    } else {
      emit(ProfileError(message: 'Profile update failed.'));
    }
  } catch (e, stackTrace) {
    log('Error occurred while fetching profile: $e', stackTrace: stackTrace);
    emit(ProfileError(message: 'An error occurred: $e'));
  }
});

  }
}
