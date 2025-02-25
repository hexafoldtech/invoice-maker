import 'package:flutter/material.dart';
import '../view/widgets/custom_bottom_bar.dart';

enum BottomBarOptions { invoices, reports }

class BottomNavigationProvider with ChangeNotifier {
  BottomBarOptions _selectedOption = BottomBarOptions.invoices;
  BottomBarOptions get selectedOption => _selectedOption;
  set selectedOption(BottomBarOptions value) {
    _selectedOption = value;
    notifyListeners();
  }

  List<BottomBarItemsModel> get bottomBarItems => [
        BottomBarItemsModel(
            icon: Icons.receipt_long,
            label: BottomBarOptions.invoices,
            buttonAction: () {
              if (_selectedOption != BottomBarOptions.invoices) {
                selectedOption = BottomBarOptions.invoices;
              }
            }),
        BottomBarItemsModel(
            icon: Icons.pie_chart_rounded,
            label: BottomBarOptions.reports,
            buttonAction: () {
              if (_selectedOption != BottomBarOptions.reports) {
                selectedOption = BottomBarOptions.reports;
              }
            })
      ];
}
