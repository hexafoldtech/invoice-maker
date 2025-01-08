import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';

class TabProvider extends ChangeNotifier {
  String title;

  TabProvider({this.title = AppStrings.createInvoice});

  void changeTitle({
    required String newTitle,
  }) async {
    title = newTitle;
    notifyListeners();
  }
}
