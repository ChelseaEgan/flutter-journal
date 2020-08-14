import 'package:shared_preferences/shared_preferences.dart';

class ThemeModePreference {
  final String _kDarkModePrefs = "isDarkMode";
  SharedPreferences prefs;

  Future<bool> getIsDarkMode() async {
    SharedPreferences sharedPrefs = await getSharedPreferences();
    return sharedPrefs.getBool(_kDarkModePrefs) ?? false;
  }

  setIsDarkMode(bool value) async {
    SharedPreferences sharedPrefs = await getSharedPreferences();
    sharedPrefs.setBool(_kDarkModePrefs, value);
  }

  Future<SharedPreferences> getSharedPreferences() async {
    if (this.prefs == null) {
      this.prefs = await SharedPreferences.getInstance();
    }
    return this.prefs;
  }
}
