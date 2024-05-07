part of 'app_theme.dart';

class OwnDarkTheme extends OwnThemeFields {
  @override
  Color get errorColor => AppColor.errorColor;
  @override
  Color get mainColor => AppColor.mainColor;
  @override
  Color get backgroundColor => AppColor.backgroundColor;
  @override
  Color get dividerColor => AppColor.dividerColor;
  @override
  Color get textColorDefault => AppColor.textColorDefault;
  @override
  Color get subTextColor => AppColor.subTextColor;
  @override
  Color get headerTextColor => AppColor.headerTextColor;
  @override
  Color get hintColor => AppColor.hintColor;
  @override
  Color get loadingCircularColor => AppColor.loadingCircularColor;
  @override
  Color get backgroundLoadingColor => AppColor.backgroundLoadingColor;
  @override
  Color get backgroundLoadingCardColor => AppColor.backgroundLoadingCardColor;
  @override
  Color get shadowColor => AppColor.shadowColor;
  @override
  TextStyle get textStyleDefault => const TextStyle(
    fontSize: 14,
  );
  @override
  TextStyle get textStyleListTitle => TextStyle(
    color: textColorDefault,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  @override
  TextStyle get textStyleListDetail => TextStyle(
    color: textColorDefault,
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );
  @override
  TextStyle get textStyleDetailTitle => TextStyle(
    color: textColorDefault,
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );
  @override
  TextStyle get textStyleDetailDescription => TextStyle(
    color: subTextColor,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  @override
  TextStyle get textStyleHeaderDefault => TextStyle(
    color: mainColor,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
  );
  @override
  TextStyle get textStyleHeaderTitle => TextStyle(
    color: textColorDefault,
    fontSize: 19,
    fontWeight: FontWeight.w400,
  );
  @override
  TextStyle get textStyleHeaderDescription => TextStyle(
    color: subTextColor,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  @override
  TextStyle get textStyleHint => TextStyle(
    color: hintColor,
    fontSize: 14,
  );
  @override
  TextStyle get textStyleMainButton => TextStyle(
    color: mainColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}
