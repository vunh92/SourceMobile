import 'dart:io';

class PlatformExtension {
  static bool get isIOS {
    return Platform.isIOS;
  }
  static bool get isAndroid {
    return Platform.isAndroid;
  }
}
