import 'package:flutter/material.dart';

class SliderModel with ChangeNotifier {
  double currentPage = 0;
  double get currentPageValue => currentPage;

  set currentPageValue(double value) {
    currentPage = value;
    notifyListeners();
  }
}
