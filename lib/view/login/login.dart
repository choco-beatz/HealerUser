import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/registeration/registeration_bloc.dart';
import 'package:healer_user/constants/snackbar.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/model/login_model/login_model.dart';
import 'package:healer_user/view/home_screen/home_screen.dart';
import 'package:healer_user/view/login/widgets/welcome.dart';
import 'package:healer_user/view/sign_up/otp_verification.dart';
import 'package:healer_user/view/sign_up/sign_up.dart';
import 'package:healer_user/view/widgets/button.dart';
import 'package:healer_user/view/widgets/dialog_button.dart';
import 'package:healer_user/view/widgets/textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocListener<RegisterationBloc, RegisterationState>(
          listener: (context, state) {
            if (state.resentOtp == true) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      "User Not Verified",
                      style: semiBold,
                    ),
                    content: const Text(
                      "Please check your email to get the OTP",
                      style: textFieldStyle,
                    ),
                    actions: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Otpscreen(
                                        email: emailController.text)));
                          },
                          child: buildButton(text: 'OK', imp: false)),
                    ],
                  );
                },
              );
            } else if (state.isVerified == true) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            } else if (state.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(loginErrorSnackBar);
            }
          },
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Welcome(),
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
                  space,
                  InkWell(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        final data = LoginModel(
                            email: emailController.text,
                            password: passwordController.text);
                        context
                            .read<RegisterationBloc>()
                            .add(LoginEvent(data: data));
                      }
                    },
                    child: const Button(text: 'Login'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Doesn't have an account? ",
                        style: textFieldStyle,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: const Text(
                            'Sign Up',
                            style: colorTextFieldStyle,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
