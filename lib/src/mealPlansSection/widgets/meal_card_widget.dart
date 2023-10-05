import 'package:flutter/material.dart';

import '../../../common/utils/appcolors.dart';

class MealCardWidget extends StatelessWidget {
  final String text;

  const MealCardWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      // width: 100,
      child: Card(
        color: AppColors.appLightColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              text.toString(),
              style: TextStyle(color: AppColors.blackcolor),
            ),
          ),
        ),
      ),
    );
  }
}
