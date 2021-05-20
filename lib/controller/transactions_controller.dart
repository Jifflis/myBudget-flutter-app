import 'dart:collection';
import 'package:meta/meta.dart';
import 'package:mybudget/controller/base_controller.dart';
import 'package:mybudget/enum/status.dart';
import 'package:mybudget/model/filter.dart';
import 'package:mybudget/repository/transaction_repository.dart';

import '../model/transaction.dart';

class TransactionsController extends BaseController {
  TransactionsController({
    @required this.transactionRepository,
    this.filters,
  });

  final TransactionRepository transactionRepository;

  List<Transaction> _transactions = <Transaction>[];

  List<Filter> filters;

  /// get unmodifiable [_transactions]
  ///
  ///
  UnmodifiableListView<Transaction> get transactions =>
      UnmodifiableListView<Transaction>(_transactions);


  @override
  void onInit() {
    filters ??= Filter.defaultFilter();

    getTransactionList();
    super.onInit();
  }

  /// initialize transaction list
  ///
  ///
  Future<void> getTransactionList() async {
    status = Status.LOADING;
    _transactions = (await transactionRepository.getTransactions(filters))??<Transaction>[];
    status = Status.COMPLETED;
  }

  /// update specific transaction from list
  ///
  ///
  Future<void> updateItem(Transaction transaction) async {
    final Transaction temp =
        await transactionRepository.getTransaction(transaction.transactionID);

    if (temp != null) {
      _transactions[_transactions.indexWhere((Transaction element) =>
          element.transactionID == transaction.transactionID)] = temp;
    } else {
      _transactions.removeWhere((Transaction element) =>
          element.transactionID == transaction.transactionID);
    }

    update();
  }

  String getCurrency() => settingsProvider.settings.currency.name;
}
