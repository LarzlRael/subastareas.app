part of 'utils.dart';

class ThemeChanger with ChangeNotifier {
  final preferences = UserPreferences();
  bool darkTheme = false;
  late ThemeData _currentTheme;

  get getCurrentTheme => _currentTheme;
  ThemeChanger(int theme) {
    switch (theme) {
      case 1:
        _currentTheme = ThemeData.light();
        darkTheme = false;
        break;
      case 2:
        _currentTheme = ThemeData.dark();
        darkTheme = true;
        break;
      default:
        _currentTheme = ThemeData.light();
        darkTheme = false;
    }
    notifyListeners();
  }

  bool get getDarkTheme => darkTheme;
  set setDarkTheme(bool value) {
    darkTheme = value;
    if (darkTheme) {
      _currentTheme = ThemeData.dark();
    } else {
      _currentTheme = ThemeData.light();
    }
    notifyListeners();
  }
}
