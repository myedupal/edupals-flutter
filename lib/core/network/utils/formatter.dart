import 'package:intl/intl.dart';

extension NumberExtension on int {
  // Format cents to RM currency
  String toCurrency({int decimalDigits = 0, bool displaySymbol = false}) {
    return NumberFormat.currency(
            locale: 'en_MY',
            symbol: displaySymbol ? 'RM' : '',
            decimalDigits: 0)
        .format(this / 100);
  }

  String formatCents() {
    return (this / 100).toString();
  }
}

extension DoubleExetension on double {
  double toPrecision({int n = 2}) => double.parse(toStringAsFixed(n));
}

extension DateTimeExtension on DateTime {
  String formatDateTime({String? pattern = 'dd-MM-yyyy'}) {
    return DateFormat(pattern).format(toLocal());
  }
}

extension StringExtension on String {
  String formatDateString({String? pattern = 'dd-MM-yyyy'}) {
    DateTime dateTime = DateTime.parse(this);
    return dateTime.formatDateTime(pattern: pattern);
  }
}
