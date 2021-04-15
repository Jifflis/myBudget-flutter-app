import 'package:intl/intl.dart';

String amountFormatter(double amount) {
  NumberFormat formatter = NumberFormat('#,##,000');
  return formatter.format(amount);
}