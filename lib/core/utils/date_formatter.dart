import 'package:intl/intl.dart';

class DateFormatter {
  const DateFormatter._();

  static String dmy(DateTime value) {
    return DateFormat('dd MMM yyyy').format(value);
  }
}
