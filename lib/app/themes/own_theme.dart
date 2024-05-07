part of 'app_theme.dart';

abstract class OwnThemeFields {
  late Color errorColor;
  late Color mainColor;
  late Color backgroundColor;
  late Color dividerColor;
  late Color textColorDefault;
  late Color subTextColor;
  late Color headerTextColor;
  late Color hintColor;
  late Color loadingCircularColor;
  late Color backgroundLoadingColor;
  late Color backgroundLoadingCardColor;
  late Color shadowColor;

  TextStyle? textStyleDefault;
  TextStyle? textStyleListTitle;
  TextStyle? textStyleListDetail;
  TextStyle? textStyleDetailTitle;
  TextStyle? textStyleDetailDescription;
  TextStyle? textStyleHeaderDefault;
  TextStyle? textStyleHeaderTitle;
  TextStyle? textStyleHeaderDescription;
  TextStyle? textStyleHint;
  TextStyle? textStyleMainButton;
}

extension ThemeDataExtensions on ThemeData {
  static final Map<Color, OwnThemeFields> _own = {};

  void addOwn(OwnThemeFields own) {
    _own[primaryColor] = own;
  }

  static OwnThemeFields? empty;

  OwnThemeFields own() {
    return _own[primaryColor]!;
  }
}
