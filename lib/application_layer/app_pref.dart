import 'package:shared_preferences/shared_preferences.dart';

import '../presentation_layer/resources/language_manager.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String sharedPrefOnBoardingKey = "UserViewedOnBoarding";
const String sharedPrefUserLoggedInKey = "UserLoggedIn";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      // return default lang
      return LanguageType.ENGLISH.getValue();
    }
  }



  /// OnBoarding setters and getters

  Future<bool> isUserSeeOnBoardingView() async {
    return  _sharedPreferences.getBool(sharedPrefOnBoardingKey) ?? false;

  }

  Future<void> setOnBoardingUserViewed() async {
    _sharedPreferences.setBool(sharedPrefOnBoardingKey , true);
  }

  /// UserLoggedIn Setters and getters
  Future<bool> isUserLoggedIn() async {
    return  _sharedPreferences.getBool(sharedPrefUserLoggedInKey) ?? false;

  }

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(sharedPrefUserLoggedInKey , true);
  }

}