import 'package:meta/meta.dart';

class Transaction {
  Transaction({
    @required this.date,
    @required this.title,
    @required this.remarks,
    @required this.amount,
  });

  String date;
  String title;
  String remarks;
  double amount;
}
