import 'package:flutter/material.dart';

class NumberConstant {
  static const defaultLimit = 20;
  // static const nearbyLocationLimit = 100;
  static const marginInfo = 60.0;
  static const heightBanner = 180.0;
  static const sizeProductImage = 50.0;
  static const heightCapture = 720.0;
  static const widthCapture = 540.0;
  static double heightDevice(BuildContext context) => MediaQuery.of(context).size.height;
  static double widthDevice(BuildContext context) => MediaQuery.of(context).size.width;

  static const basePaddingSmall = 4.0;
  static const basePaddingMedium = 8.0;
  static const basePaddingLarge = 16.0;
  static const baseRadiusBorderSmall = 4.0;
  static const baseRadiusBorderMedium = 8.0;
  static const baseRadiusBorderLarge = 16.0;

  static const baseSizeAvatarSmall = 40.0;
  static const baseSizeIconMedium = 24.0;
  static const baseSizeIconSmall = 18.0;

  static const compressImageQuality = 50;
  static const compressImagePercentage = 50;
}
