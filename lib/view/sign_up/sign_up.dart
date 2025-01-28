import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/registeration/registeration_bloc.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/snackbar.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/model/signup_model/signup_model.dart';
import 'package:healer_user/view/sign_up/otp_verification.dart';
import 'package:healer_user/view/sign_up/widgets/gender_dropdown.dart';
import 'package:healer_user/view/sign_up/widgets/onboard.dart';
import 'package:healer_user/view/widgets/button.dart';
import 'package:healer_user/view/widgets/textformfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? selectedGender;
  final TextEditingController emailController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    File? image;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(

        // appBar: AppBar(),
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: BlocListener<RegisterationBloc, RegisterationState>(
            listener: (context, state) {
              if (state.isSuccess == true) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Otpscreen(
                              email: emailController.text,
                            )));
              } else {
                log(state.isSuccess.toString());
              }
            },
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Onboadrd(),
                  Center(
                      child: InkWell(onTap: () {
                    context.read<RegisterationBloc>().add(PickImageEvent());
                  }, child: BlocBuilder<RegisterationBloc, RegisterationState>(
                          builder: (context, state) {
                    if (state.pickedImage != null) {
                      image = state.pickedImage;
                      return CircleAvatar(
                        radius: 70,
                        child: ClipOval(
                          child: Image.file(
                            state.pickedImage!,
                            fit: BoxFit.cover,
                            width: 140,
                            height: 140,
                          ),
                        ),
                      );
                    }
                    return const CircleAvatar(
                        backgroundColor: main1,
                        radius: 70,
                        foregroundColor: white,
                        child: Icon(
                          Icons.camera_alt,
                          size: 80,
                        ));
                  }))),
                  buildTextFormField(
                    label: ' Name',
                    controller: nameController,
                    validator: (value) => value == null || value.isEmpty
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
                  buildTextFormField(
                    label: ' Email',
                    controller: emailController,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter the email'
                        : null,
                    hint: 'Enter the email',
                  ),
                  space,
                  buildTextFormField(
                    label: ' Password',
                    controller: passwordController,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter the password'
                        : null,
                    hint: 'Enter the password',
                  ),
                  space,
                  buildTextFormField(
                    label: ' Confirm password',
                    controller: confirmPasswordController,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter the password again'
                        : null,
                    hint: 'Confirm password',
                  ),
                  
                  space,
                  space,
                  InkWell(
                    onTap: () {
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(misMatch);
                      } else if (formkey.currentState!.validate()) {
                        final data = SignupModel(
                            email: emailController.text,
                            age: int.tryParse(ageController.text)!,
                            gender: selectedGender!,
                            password: passwordController.text,
                            name: nameController.text);
                        context
                            .read<RegisterationBloc>()
                            .add(SignUpEvent(data: data, imageFile: image));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(somethingWentWrong);
                      }
                    },
                    child: const Button(text: 'Sign Up'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
    //   ),
    // );
  }
}
