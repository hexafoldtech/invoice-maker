import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'invoice_provider.dart';
import '../core/constants/global_key.dart';

class ReportsProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _quarterlyData = [];
  double _total = 0.0;

  List<Map<String, dynamic>> get quarterlyData => _quarterlyData;
  double get total => _total;

  void getData() async {
    var invoiceProvider = Provider.of<InvoiceProvider>(
        navigatorKey.currentContext!,
        listen: false);
    await invoiceProvider.fetchInvoices();
    var invoices = invoiceProvider.invoices;

    List<String> allMonths = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    /// Initialize quarterly data structure
    Map<String, Map<String, dynamic>> quarterData = {
      'Q1': {
        'total': 0.0,
        'months': {for (var month in allMonths.sublist(0, 3)) month: 0.0}
      },
      'Q2': {
        'total': 0.0,
        'months': {for (var month in allMonths.sublist(3, 6)) month: 0.0}
      },
      'Q3': {
        'total': 0.0,
        'months': {for (var month in allMonths.sublist(6, 9)) month: 0.0}
      },
      'Q4': {
        'total': 0.0,
        'months': {for (var month in allMonths.sublist(9, 12)) month: 0.0}
      },
    };
    Map<String, double> monthlyTotals = {};
    double grandTotal = 0.0;

    /// Iterate through invoices to populate quarterly data
    for (var invoice in invoices) {
      DateTime dueDate = invoice.dueDate;
      String fullMonth = DateFormat('MMMM').format(dueDate);
      double amount = invoice.total;

      /// Determine which quarter the due date falls into
      String quarter = getQuarter(dueDate);

      /// Update the quarterly data
      if (!quarterData[quarter]!['months'].containsKey(fullMonth)) {
        quarterData[quarter]!['months'][fullMonth] = 0.0;
      }
      quarterData[quarter]!['months'][fullMonth] += amount;
      quarterData[quarter]!['total'] += amount;
      if (!monthlyTotals.containsKey(fullMonth)) {
        monthlyTotals[fullMonth] = 0.0;
      }
      monthlyTotals[fullMonth] = monthlyTotals[fullMonth]! + amount;

      /// Update grand total
      grandTotal += amount;

      _total = grandTotal;
      notifyListeners();
    }

    /// Convert map to list format
    _quarterlyData = quarterData.entries.map((entry) {
      return {
        'quarter': entry.key,
        'total': entry.value['total'],
        'months': entry.value['months'].entries
            .map((monthEntry) =>
                {'month': monthEntry.key, 'amount': monthEntry.value})
            .toList()
      };
    }).toList();
    notifyListeners();
  }

  String getQuarter(DateTime date) {
    int month = date.month;
    if (month >= 1 && month <= 3) return 'Q1';
    if (month >= 4 && month <= 6) return 'Q2';
    if (month >= 7 && month <= 9) return 'Q3';
    return 'Q4';
  }
}
