part of 'utils.dart';

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

  List<String> get getSubjectsList {
    return _preferences.getStringList('subjectsList') ?? [];
  }

  set setSubjectsList(List<String> listSubjects) {
    _preferences.setStringList('subjectsList', listSubjects);
  }

  int get getThemeStatus {
    return _preferences.getInt('themeStatus') ?? 0;
  }

  set setThemeStatus(int themeStatus) {
    _preferences.setInt('themeStatus', themeStatus);
  }
}
