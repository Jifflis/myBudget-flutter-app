import 'dart:collection';
import 'package:meta/meta.dart';
import 'package:mybudget/controller/base_controller.dart';
import 'package:mybudget/enum/status.dart';
import 'package:mybudget/repository/transaction_repository.dart';

import '../model/transaction.dart';

class TransactionsController extends BaseController {
  TransactionsController({
    @required this.transactionRepository,
  });

  final TransactionRepository transactionRepository;

  List<Transaction> _transactions = <Transaction>[];

  /// get unmodifiable [_transactions]
  ///
  ///
  UnmodifiableListView<Transaction> get transactions =>
      UnmodifiableListView<Transaction>(_transactions);

  /// initialize transaction list
  ///
  ///
  Future<void> getTransactionList() async {
    status = Status.LOADING;
    _transactions = await transactionRepository.getTransactions();
    status = Status.COMPLETED;
  }

  /// update specific transaction
  ///
  ///
  Future<void> updateItem(Transaction transaction) async {
    final Transaction temp =
        await transactionRepository.getTransaction(transaction.transactionID);

    _transactions[_transactions.indexWhere((Transaction element) =>
        element.transactionID == transaction.transactionID)] = temp;

    update();
  }
}
