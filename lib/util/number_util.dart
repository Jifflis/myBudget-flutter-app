import 'package:intl/intl.dart';

String amountFormatter(double amount) {
  final NumberFormat formatter = NumberFormat('#,###,##0.00');
  return formatter.format(amount);
}
