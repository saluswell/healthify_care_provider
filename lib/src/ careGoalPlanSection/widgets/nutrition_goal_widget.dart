import 'package:flutter/material.dart';

import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';

class NutritionGoalWidget extends StatelessWidget {
  final String text;
  final double width;

  const NutritionGoalWidget({
    Key? key,
    required this.text,
    this.width = 140,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        elevation: 3,
        child: Center(
          child: Text(
            text,
            style: fontW5S12(context)!.copyWith(
                fontSize: 13,
                color: AppColors.blackcolor,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
