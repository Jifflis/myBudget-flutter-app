import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/transaction.dart';

class TransactionsController extends GetxController {
  //date format used YYYY-MM-DD
  List<Transaction> transactionList = <Transaction>[
    Transaction(
        date: '2021-04-21',
        title: 'Rent',
        remarks: 'Monthly bill',
        amount: 2000.0),
    Transaction(
        date: '2021-04-22',
        title: 'Food Allowance',
        remarks: 'Monthly Payment',
        amount: 5000.0),
    Transaction(
        date: '2021-04-23',
        title: 'Others',
        remarks: 'Monthly bill',
        amount: 1000.0),
    Transaction(
        date: '2021-04-24',
        title: 'Milk',
        remarks: 'Monthly payment',
        amount: 1000.0),
    Transaction(
        date: '2021-04-25',
        title: 'Diaper',
        remarks: 'Monthly payment',
        amount: 2500.0),
  ];
}
