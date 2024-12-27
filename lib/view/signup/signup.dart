import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/registeration/registeration_bloc.dart';
import 'package:healer_user/constants/snackbar.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/model/signupmodel/signup_model.dart';
import 'package:healer_user/view/signup/otp_verification.dart';
import 'package:healer_user/view/signup/widgets/onboard.dart';
import 'package:healer_user/view/widgets/button.dart';
import 'package:healer_user/view/widgets/textfield.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
              }
              else{
                log(state.isSuccess.toString());
              }
            },
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Onboadrd(),
                  SizedBox(
                    height: 55,
                    width: width * 0.9,
                    child: TextFormField(
                        controller: nameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the name';
                          }
                          return null;
                        },
                        decoration: textField('Name'),
                        cursorColor: Colors.black26,
                        style: textFieldStyle),
                  ),
                  space,
                  SizedBox(
                    height: 55,
                    width: width * 0.9,
                    child: TextFormField(
                        controller: emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the email';
                          }
                          return null;
                        },
                        decoration: textField('Email'),
                        cursorColor: Colors.black26,
                        style: textFieldStyle),
                  ),
                  space,
                  SizedBox(
                    height: 55,
                    width: width * 0.9,
                    child: TextFormField(
                        controller: passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the password';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        decoration: textField('Password'),
                        cursorColor: Colors.black26,
                        style: textFieldStyle),
                  ),
                  space,
                  SizedBox(
                    height: 55,
                    width: width * 0.9,
                    child: TextFormField(
                        controller: confirmPasswordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the password';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        decoration: textField('Confirm Password'),
                        cursorColor: Colors.black26,
                        style: textFieldStyle),
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
                            password: passwordController.text,
                            name: nameController.text);
                        context
                            .read<RegisterationBloc>()
                            .add(SignUpEvent(data: data));
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
