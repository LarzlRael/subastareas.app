import 'package:flutter/foundation.dart';

class FilterProvider with ChangeNotifier {
  final List<String> _listLevelSelected = [];
  final List<String> _listCategorySelected = [];
  bool _showButtonAcept = false;

  bool get getShowButtonAcept => _showButtonAcept;
  set setShowButtonAcept(bool value) {
    _showButtonAcept = value;
    notifyListeners();
  }

  List<String> get getListLevelSelected => _listLevelSelected;

  List<String> get getListAllSelected =>
      [..._listCategorySelected, ..._listLevelSelected];

  set setAddListLevelSelected(String value) {
    if (_listLevelSelected.contains(value)) {
      _listLevelSelected.remove(value);
    } else {
      _listLevelSelected.add(value);
    }
    notifyListeners();
  }

  List<String> get getListCategorySelected => _listCategorySelected;
  set setAddListCategorySelected(String value) {
    if (_listCategorySelected.contains(value)) {
      _listCategorySelected.remove(value);
    } else {
      _listCategorySelected.add(value);
    }
    notifyListeners();
  }

  removeItemFromList(String value) {
    if (_listLevelSelected.contains(value)) {
      _listLevelSelected.remove(value);
    }
    if (_listCategorySelected.contains(value)) {
      _listCategorySelected.remove(value);
    }
    notifyListeners();
  }
}
