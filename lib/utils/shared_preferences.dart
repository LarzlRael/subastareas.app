import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  //no one this properties it is used

  static final UserPreferences _instance = UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  late SharedPreferences _preferences;

  initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String get loginEmail {
    return _preferences.getString('loginEmail') ?? '';
  }

  set loginEmail(String value) {
    _preferences.setString('loginEmail', value);
  }

  bool get showInitialSlider {
    return _preferences.getBool('showInitialSlider') ?? true;
  }

  set setShowInitialSlider(bool value) {
    _preferences.setBool('showInitialSlider', value);
  }
}
