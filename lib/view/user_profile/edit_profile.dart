import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/registeration/registeration_bloc.dart';
import 'package:healer_user/bloc/user/user_bloc.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/snackbar.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/model/profile_model/profile_model.dart';
import 'package:healer_user/view/home_screen/home_screen.dart';
import 'package:healer_user/view/sign_up/widgets/gender_dropdown.dart';
import 'package:healer_user/view/widgets/appbar.dart';
import 'package:healer_user/view/widgets/button.dart';
import 'package:healer_user/view/widgets/textformfield.dart';

class EditProfile extends StatefulWidget {
  final UserModel user;
  const EditProfile({
    super.key,
    required this.user,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late TextEditingController nameController;
  String? selectedGender;
  late TextEditingController ageController;
  late TextEditingController genderController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.profile.name);

    ageController =
        TextEditingController(text: widget.user.profile.age.toString());
    genderController = TextEditingController(text: widget.user.profile.gender);
    selectedGender = widget.user.profile.gender;
  }

  @override
  Widget build(BuildContext context) {
    File? image;
    // double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CommonAppBar(
            title: 'Edit User',
          )),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(children: [
            Card(
                child: Form(
                    key: formkey,
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: InkWell(
                                onTap: () {
                                  context
                                      .read<RegisterationBloc>()
                                      .add(PickImageEvent());
                                },
                                child: BlocBuilder<RegisterationBloc,
                                    RegisterationState>(
                                  builder: (context, state) {
                                    if (state.pickedImage != null) {
                                      image = state.pickedImage;
                                      return Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            CircleAvatar(
                                              radius: 70,
                                              child: ClipOval(
                                                child: Image.file(
                                                  state.pickedImage!,
                                                  fit: BoxFit.cover,
                                                  width: 140,
                                                  height: 140,
                                                ),
                                              ),
                                            ),
                                            const Positioned(
                                                top: 90,
                                                left: 100,
                                                child: CircleAvatar(
                                                  backgroundColor: main1,
                                                  radius: 25,
                                                  foregroundColor: white,
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    size: 30,
                                                  ),
                                                ))
                                          ]);
                                    } else {
                                      return Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            CircleAvatar(
                                              radius: 70,
                                              child: ClipOval(
                                                child: Image.network(
                                                  widget.user.image,
                                                  fit: BoxFit.cover,
                                                  width: 140,
                                                  height: 140,
                                                ),
                                              ),
                                            ),
                                            const Positioned(
                                                top: 90,
                                                left: 100,
                                                child: CircleAvatar(
                                                  backgroundColor: main1,
                                                  radius: 25,
                                                  foregroundColor: white,
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    size: 30,
                                                  ),
                                                ))
                                          ]);
                                    }
                                  },
                                ),
                              )),
                              space,
                              buildTextFormField(
                                label: ' Name',
                                controller: nameController,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please enter the name'
                                        : null,
                                hint: 'Enter the name',
                              ),
                              space,
                              buildDropdownField(
                                label: 'Gender',
                                value: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a gender';
                                  }
                                  return null;
                                },
                              ),
                              space,
                              buildTextFormField(
                                label: ' Age',
                                controller: ageController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your age';
                                  }
                                  final age = int.tryParse(value);
                                  if (age == null) {
                                    return 'Please enter a valid number';
                                  }
                                  if (age < 18) {
                                    return 'Age must be 18 or older';
                                  }
                                  if (age > 120) {
                                    return 'Please enter a valid age';
                                  }
                                  return null;
                                },
                              ),
                              space,
                            ])))),
            space,
            InkWell(
              onTap: () {
                if (formkey.currentState!.validate()) {
                  context.read<UserBloc>().add(EditProfileEvent(
                      name: nameController.text,
                      gender: selectedGender!,
                      age: int.tryParse(ageController.text)!,
                      image: image));
                  context.read<UserBloc>().add(GetProfileEvent());
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(somethingWentWrong);
                }
              },
              child: const Button(text: 'Save'),
            ),
            space
          ]))),
    );
  }
}
