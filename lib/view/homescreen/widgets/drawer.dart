import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/registeration/registeration_bloc.dart';
import 'package:healer_user/view/login/login.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child:
            BlocListener<RegisterationBloc, RegisterationState>(
                listener: (context, state) {
                  if (state.redirect == true) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }
                },
            child:
            ListTile(
      onTap: () {
        context.read<RegisterationBloc>().add(LogOutEvent());
      },
      leading: const Icon(Icons.logout_outlined),
      title: const Text("Log out"),
    ))

    );
  }
}
