import 'package:shared_preferences/shared_preferences.dart';

enum SharedPreFerencesKey {
  appTime,
}

class SharedPreferencesUtil {
  SharedPreferencesUtil._internal();

  static final SharedPreferencesUtil getInstance =
  SharedPreferencesUtil._internal();

  static late SharedPreferences sharedPreferences;

  Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> putData(SharedPreFerencesKey putKey, T) async {
    final key = putKey.value();
    if (key.isEmpty) {
      return Future.value(false);
    }
    switch (T.runtimeType) {
      case String:
        return sharedPreferences.setString(key, T);
      case int:
        return sharedPreferences.setInt(key, T);
      case double:
        return sharedPreferences.setDouble(key, T);
      case bool:
        return sharedPreferences.setBool(key, T);
      default:
        return Future.value(false);
    }
  }

  Future<bool> removeData(SharedPreFerencesKey key) async {
    return sharedPreferences.remove(key.value());
  }

  T? get<T>(SharedPreFerencesKey key) {
    var result = sharedPreferences.get(key.value());
    if(result == null) return null;
    return result as T;
  }

  Future<bool> clearData() async {
    return sharedPreferences.clear();
  }
}

extension SharedPreferencesUtilHelper on SharedPreFerencesKey {
  String value() {
    switch (this) {
      case SharedPreFerencesKey.appTime:
        return "currentDate";
      default:
        return "";
    }
  }
}