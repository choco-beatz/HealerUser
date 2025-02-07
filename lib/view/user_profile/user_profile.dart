import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/gradient.dart';
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
      body: Stack(
        children: [
          Container(
            height: height,
            decoration: const BoxDecoration(
              gradient: gradient,
            ),
          ),
          Positioned(
              top: 50,
              left: 5,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.chevron_left,
                        color: white,
                        size: 35,
                      )),
                  hSpace,
                  const Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 18,
                        color: white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )),
          Positioned(
            top: 200,
            child: Container(
              width: width,
              height: height * 0.8,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.125),
                child: Column(
                  children: [
                    Text(
                      user.profile.gender == 'male'
                          ? 'Mr. ${user.profile.name}'
                          : 'Ms. ${user.profile.name}',
                      style: semiBold,
                    ),
                    space,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gender : ${user.profile.gender}',
                          style: smallTextBold,
                        ),
                        Text(
                          'Age : ${user.profile.age}',
                          style: smallTextBold,
                        ),
                      ],
                    ),
                    space,
                    Text(
                      'Contact info : ${user.email}',
                      style: smallTextBold,
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.15,
            left: width * 0.3,
            child: CircleAvatar(
              backgroundColor: main1,
              radius: 80,
              child: ClipOval(
                child: Image.network(
                  user.image,
                  fit: BoxFit.cover,
                  width: 160,
                  height: 160,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: width * 0.1,
            child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfile(user: user))),
                child: const Button(text: 'Edit')),
          )
        ],
      ),
    );
  }
}
