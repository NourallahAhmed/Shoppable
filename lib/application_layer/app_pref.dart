import 'package:Shoppable/application_layer/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation_layer/resources/language_manager.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String sharedPrefOnBoardingKey = "UserViewedOnBoarding";
const String sharedPrefUserLoggedInKey = "UserLoggedIn";
const String sharedPrefUserName = "UserName";
const String sharedPrefEmail = "Email";
const String sharedPrefPhone = "Phone";

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

  Future<void> setUserData( String email , String userName , String phone) async{
    _sharedPreferences.setString(sharedPrefUserName , userName);
    _sharedPreferences.setString(sharedPrefEmail , email);
    _sharedPreferences.setString(sharedPrefPhone , phone);
  }


  Future<String> getUserName() async {
    return _sharedPreferences.getString(sharedPrefUserName).orEmpty();
  }

  Future<String> getEmail() async {
    return _sharedPreferences.getString(sharedPrefEmail).orEmpty();
  }

  Future<String> getPhone() async {
    return _sharedPreferences.getString(sharedPrefPhone).orEmpty();
  }
}