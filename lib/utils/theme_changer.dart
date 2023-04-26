part of 'utils.dart';

class ThemeChanger with ChangeNotifier {
  bool notifications = false;
  int _currentHomeworksTabIndex = 0;

  int get getCurrentHomeworksTabIndex => _currentHomeworksTabIndex;
  set setCurrentHomeworksTabIndex(int value) {
    _currentHomeworksTabIndex = value;
    notifyListeners();
  }

  bool get getNotifications => notifications;
  set setNotifications(bool value) {
    notifications = value;
    notifyListeners();
  }
}
