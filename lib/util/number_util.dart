import 'package:intl/intl.dart';

String amountFormatter(double amount) {
  final NumberFormat formatter = NumberFormat('#,##,000');
  return formatter.format(amount);
}