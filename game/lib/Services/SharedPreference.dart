// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static void saveValue(String key, Object value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    }
  }

  static Future<dynamic> getValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Object? value = prefs.get(key);
    return value;
  }

  static Future<bool> deleteValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove(key);
  }
}
