import 'package:flutter/material.dart';

import '../utils/appcolors.dart';
import 'navigatorHelper.dart';

class DialogHelper {
  static showBottomSheet({required Widget widget}) {
    showModalBottomSheet(
      backgroundColor: AppColors.whitecolor,
      context: navstate.currentState!.context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(17), topRight: Radius.circular(17))),
      builder: (BuildContext context) {
        return widget;
      },
    );
  }
}
