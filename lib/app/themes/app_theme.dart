import 'package:flutter/material.dart';

import '../colors/app_color.dart';

part 'dark_theme.dart';
part 'light_theme.dart';
part 'own_theme.dart';

enum AppThemeType {
  light,
  dark,
}

extension AppThemeTypeHelper on AppThemeType {
  ThemeData getTheme(BuildContext context) {
    if (this == AppThemeType.light) {
      return AppTheme.light(context);
    }
    return AppTheme.dark(context);
  }
}

class AppTheme {
  static ThemeData light(BuildContext context) {
    return ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
        color: AppColor.mainColor,
        shadowColor: AppColor.mainColor,
      ),
    )..addOwn(
        OwnLightTheme(),
      );
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData.dark()
      ..addOwn(
          OwnDarkTheme(),
      );
  }
}
