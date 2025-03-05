import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String toFormattedString() {
    return DateFormat('dd MMM yyyy').format(this);
  }
}
