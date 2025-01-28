// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

class UserEvent {}

class GetProfileEvent extends UserEvent {}

class EditProfileEvent extends UserEvent {
  String name;
  String gender;
  int age;
  File? image;
  EditProfileEvent({
    required this.name,
    required this.gender,
    required this.age,
    this.image,
  });
}
