import 'package:shared_preferences/shared_preferences.dart';

class StorageC {
  static const String _ThemeStoreKey = 'isDarkMode';
  static const String _LangStoreKey = 'isLang';
  static const String _ProfileStoreKey = 'profilePath';

  static Future<void> saveThemeMode(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_ThemeStoreKey, isDarkMode);
  }

  static getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_ThemeStoreKey) ?? true;
  }

  ///////////////////////////////////////
  static Future<void> saveLangMode(bool isLangEng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_LangStoreKey, isLangEng);
  }

  static getLangMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_LangStoreKey) ?? true;
  }

  ///////////////////////////////////////
  static Future<void> setProfilePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_ProfileStoreKey, path);
  }

  static getProfilePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_ProfileStoreKey) ?? '';
  }
}
