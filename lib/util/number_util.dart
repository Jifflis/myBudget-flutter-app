import 'package:intl/intl.dart';

String amountFormatter(double amount) {
  final NumberFormat formatter = NumberFormat('#,##,000');
  return formatter.format(amount);
}

/// SIMPLIFY DATE
/// expected date format YYYY-MM-DD
///
Map<String, dynamic> dateSimplified(String date) {
  final List<String> dateItems = date.split('-');

  return <String, dynamic>{
    'YYYY': dateItems[0],
    'MM': getMonth(int.parse(dateItems[1])),
    'DD': dateItems[2],
  };
}

String getMonth(int monthNumber) {
  switch (monthNumber) {
    case 1:
      return 'JAN';
      break;
    case 2:
      return 'FEB';
      break;
    case 3:
      return 'MAR';
      break;
    case 4:
      return 'APR';
      break;
    case 5:
      return 'MAY';
      break;
    case 6:
      return 'JUN';
      break;
    case 7:
      return 'JUL';
      break;
    case 8:
      return 'AUG';
      break;
    case 9:
      return 'SEP';
      break;
    case 10:
      return 'OCT';
      break;
    case 11:
      return 'NOV';
      break;
    case 12:
      return 'DEC';
      break;
    default:
      return 'N/A';
  }
}
