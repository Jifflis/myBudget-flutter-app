/// return last date of the month
///
DateTime getLastDateOfMonth({DateTime date}) {
  final DateTime dateNow = date ?? DateTime.now();
  return DateTime(dateNow.year, dateNow.month + 1, 0);
}

/// return next last date of the month
///
DateTime getNextMonthLastDate(DateTime date) {
  return DateTime(date.year, date.month + 2, 0);
}

/// Return a date with a time of `00:00:00`
/// according to the given parameter [date]
///
DateTime resetTime(DateTime date) {
  return DateTime(date.year, date.month, 0);
}


/// Simplify Date
/// expected date format YYYY-MM-DD
///
Map<String, dynamic> dateSimplified(String date) {
  final List<String> firstSplit = date.split(' ');
  final List<String> dateItems = firstSplit[0].split('-');

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

String getFullMonth(int monthNumber) {
  switch (monthNumber) {
    case 1:
      return 'January';
      break;
    case 2:
      return 'February';
      break;
    case 3:
      return 'March';
      break;
    case 4:
      return 'April';
      break;
    case 5:
      return 'May';
      break;
    case 6:
      return 'June';
      break;
    case 7:
      return 'July';
      break;
    case 8:
      return 'August';
      break;
    case 9:
      return 'September';
      break;
    case 10:
      return 'October';
      break;
    case 11:
      return 'November';
      break;
    case 12:
      return 'December';
      break;
    default:
      return 'N/A';
  }
}
