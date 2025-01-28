part of 'user_bloc.dart';

class UserState {}

class UserInitial extends UserState {}

class ProfileLoading extends UserState {}

class ProfileLoaded extends UserState {
  final UserModel user;

  ProfileLoaded({required this.user});
}

class ProfileError extends UserState {
  final String message;

  ProfileError({required this.message});
}
