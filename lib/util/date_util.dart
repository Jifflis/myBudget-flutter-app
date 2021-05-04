
DateTime getLastDateOfMonth(){
  final DateTime dateNow = DateTime.now();
  return DateTime(dateNow.year, dateNow.month + 1, 0);
}