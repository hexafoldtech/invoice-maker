import 'package:flutter/material.dart';
import 'package:invoice_maker/view/dashboard_screen/main_screen.dart';
import 'package:invoice_maker/view/dashboard_screen/reports_screen/reports_screens.dart';

class BottomNavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Widget get currentPage {
    switch (_currentIndex) {
      case 0:
        return const MainScreen();
      case 1:
        return const ReportsScreens();
      default:
        return const MainScreen();
    }
  }
}
