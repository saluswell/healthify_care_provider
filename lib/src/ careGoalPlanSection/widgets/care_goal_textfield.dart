import 'package:flutter/material.dart';

import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';

class CareGoalTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool enabled;

  const CareGoalTextField(
      {Key? key, required this.hintText, this.controller, this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        elevation: 3,
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              enabled: enabled,
              contentPadding: EdgeInsets.only(left: 10, bottom: 5),
              hintStyle: fontW5S12(context)!.copyWith(
                  fontSize: 13,
                  color: AppColors.lightdarktextcolor,
                  fontWeight: FontWeight.w500),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
