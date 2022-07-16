
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static late SharedPreferences _pref;

  static bool _isDarkmode = false;

  static Future init() async {
    _pref =  await SharedPreferences.getInstance();
  }

  static bool get isDarkmode {
    return _pref.getBool('isDarkmode') ?? _isDarkmode;
  }

  static set isDarkmode(bool value) {
    _isDarkmode = value;
    _pref.setBool('isDarkmode', value);
  }

}