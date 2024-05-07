import 'package:flutter/material.dart';

import '../../app/utlis/utils.dart';

class AppTextStyle {
  static TextStyle get textStyleLoading => const TextStyle(
    fontSize: 16,
    height: 20 / 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  static TextStyle get textStyleListDefault => TextStyle(
    color: AppColor.appColorDark2,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle get textStyleAppBar => const TextStyle(
    fontSize: 16.0,
  );
}
