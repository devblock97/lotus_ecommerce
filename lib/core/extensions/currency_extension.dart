import 'dart:io';

import 'package:intl/intl.dart';

extension CurrencyExtension on String {
  String format({required String code}) {
    final currencyFormatter = NumberFormat.simpleCurrency(locale: Platform.localeName, name: code);
    return currencyFormatter.format(double.parse(this));
  }
}