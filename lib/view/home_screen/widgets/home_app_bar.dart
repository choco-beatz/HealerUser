import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/user/user_bloc.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/gradient.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/view/home_screen/widgets/greetings.dart';
import 'package:healer_user/view/user_profile/user_profile.dart';
import 'package:healer_user/view/widgets/loading.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(GetProfileEvent()),
      child: Container(
        height: height * 0.2,
        width: width,
        decoration: const BoxDecoration(gradient: gradient),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Loading();
              } else if (state is ProfileLoaded) {
                final user = state.user;
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: user))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Greeting(),
                          Text(
                            user.profile.gender == 'male'
                                ? 'Mr. ${user.profile.name}'
                                : 'Ms. ${user.profile.name}',
                            style: bigBoldWhite,
                          )
                        ],
                      ),
                      CircleAvatar(
                          backgroundColor: fieldBG,
                          radius: 55,
                          child: (user.image.split('.').last == 'png')
                              ? Image.network(
                                  fit: BoxFit.fitHeight,
                                  user.image,
                                  width: 110,
                                  height: 110,
                                )
                              : ClipOval(
                                  child: Image.network(
                                    fit: BoxFit.fitHeight,
                                    user.image,
                                    width: 110,
                                    height: 110,
                                  ),
                                ))
                    ],
                  ),
                );
              } else if (state is ProfileError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const Center(child: Text('Welcome!'));
            },
          ),
        ),
      ),
    );
  }
}
