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

  static showCommonGeneralDialog({required Widget widget}) {
    showGeneralDialog(
      context: navstate.currentState!.context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(navstate.currentState!.context)
          .modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return widget;
      },
    );
  }
}
