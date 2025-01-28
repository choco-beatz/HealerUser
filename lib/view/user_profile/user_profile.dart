import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/model/profile_model/profile_model.dart';
import 'package:healer_user/view/user_profile/edit_profile.dart';
import 'package:healer_user/view/widgets/button.dart';

class UserProfileScreen extends StatelessWidget {
  final UserModel user;
  const UserProfileScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                  fit: BoxFit.fitWidth,
                  width: width,
                  height: height * 0.3,
                  user.image),
              Positioned(
                  top: 30,
                  left: 25,
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.chevron_left,
                        color: black,
                        size: 35,
                      )))
            ],
          ),
          SizedBox(
            height: height * 0.6,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.profile.gender == 'male'
                          ? 'Mr. ${user.profile.name}'
                          : 'Ms. ${user.profile.name}',
                      style: semiBold,
                    ),
                    space,
                    const Text(
                      'Age',
                      style: smallBold,
                    ),
                    smallSpace,
                    Text(
                      user.profile.age.toString(),
                      style: textFieldStyle,
                    ),
                    space,
                    const Text(
                      'Gender',
                      style: smallBold,
                    ),
                    smallSpace,
                    Text(
                      user.profile.gender,
                      style: textFieldStyle,
                    ),
                    space,
                    const Text(
                      'Contact',
                      style: smallBold,
                    ),
                    smallSpace,
                    Text(
                      user.email,
                      style: textFieldStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
              child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfile(user: user))),
                  child: Button(text: 'Edit')))
        ],
      ),
    );
  }
}
