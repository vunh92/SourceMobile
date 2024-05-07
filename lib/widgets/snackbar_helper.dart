import 'package:cooler_mdlz/app/utlis/utils.dart';
import 'package:flutter/material.dart';

class _Constant {
  static double borderRadius = 5;
  static double elevation = 6;
}

class SnackHelper {
  static void showMessage({
    required BuildContext context,
    required String message,
    double marginHorizontal = 0,
    double marginVertical = 0,
  }) {
    final themeOwn = Theme.of(context).own();
    final snackBar = SnackBar(
      content: Text(message),
      elevation: _Constant.elevation,
      backgroundColor: themeOwn.mainColor.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(_Constant.borderRadius)),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: marginHorizontal,
        vertical: marginVertical,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
