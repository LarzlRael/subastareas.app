part of 'providers.dart';

class GlobalProvider with ChangeNotifier {
  final List<String> _listLevelSelected = [];

  bool _showButtonAccept = false;
  int _currentBottomTab = 0;

  int get getCurrentBottomTab => _currentBottomTab;
  set setCurrentBottomTab(int value) {
    _currentBottomTab = value;
    notifyListeners();
  }

  bool get getShowButtonAccept => _showButtonAccept;
  set setShowButtonAccept(bool value) {
    _showButtonAccept = value;
    notifyListeners();
  }

  List<String> get getListLevelSelected => _listLevelSelected;

  set setAddListLevelSelected(String value) {
    if (_listLevelSelected.contains(value)) {
      _listLevelSelected.remove(value);
    } else {
      _listLevelSelected.add(value);
    }
    notifyListeners();
  }

  removeItemFromList(String value) {
    if (_listLevelSelected.contains(value)) {
      _listLevelSelected.remove(value);
    }

    notifyListeners();
  }
}