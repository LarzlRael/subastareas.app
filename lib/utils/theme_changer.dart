part of 'utils.dart';

class ThemeChanger with ChangeNotifier {
  final preferences = UserPreferences();
  bool isDarkTheme = false;
  late ThemeData _currentTheme;

  get getCurrentTheme => _currentTheme;
  ThemeChanger(int theme) {
    switch (theme) {
      case 1:
        _currentTheme = ThemeData.light();
        isDarkTheme = false;
        break;
      case 2:
        _currentTheme = ThemeData.dark();
        isDarkTheme = true;
        break;
      default:
        _currentTheme = ThemeData.light();
        isDarkTheme = false;
    }
    notifyListeners();
  }

  bool get getDarkTheme => isDarkTheme;
  set setDarkTheme(bool value) {
    isDarkTheme = value;
    if (isDarkTheme) {
      _currentTheme = ThemeData.dark();
    } else {
      _currentTheme = ThemeData.light();
    }
    notifyListeners();
  }
}
