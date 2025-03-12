import 'package:intl/intl.dart';

extension DoubleFormatter on double {
  String formatWithCommas({int decimalPlaces = 2}) {
    final formatter = NumberFormat('#,##0.${'0' * decimalPlaces}', 'en_US');
    return formatter.format(this);
  }
}
