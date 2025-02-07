import 'package:flutter/material.dart';

import '../view/widgets/custom_app_bar.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardAppBarButtons _buttonTapped = DashboardAppBarButtons.invoices;
  DashboardAppBarButtons get buttonTapped => _buttonTapped;
  set buttonTapped(DashboardAppBarButtons value) {
    _buttonTapped = value;
    notifyListeners();
  }
}
