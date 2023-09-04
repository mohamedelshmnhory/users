import 'package:flutter/material.dart';
import 'package:users/core/extensions/navigator.dart';
import 'package:users/core/faker/app_faker.dart';
import 'package:users/features/users/view/screens/user_details.dart';

import '../../../../core/resources.dart';
import '../../data/models/user_response_model.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          context.push(UserDetailsScreen(user: user));
        },
        child: Padding(
          padding: symmetricPadding(20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              15.heightBox(),
              Hero(
                tag: 'userAvatar${user.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: ImageLoader(path: user.avatar ?? AppFaker.randomImage),
                ),
              ),
              15.heightBox(),
              AppText(user.first_name ?? '-', style: AppStyles.bold18.copyWith(color: Colors.white)),
              10.heightBox(),
              AppText(user.last_name ?? '-', style: AppStyles.medium16.copyWith(color: Colors.white)),
              10.heightBox(),
              AppText(user.email ?? '-', style: AppStyles.medium14.copyWith(color: Colors.white)),
              10.heightBox(),
              const Divider(height: 1, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  List<Color> get colors {
    final colors = [AppColors.watermelonWithOpacity, AppColors.appRed];
    colors.shuffle();
    return colors;
  }
}
