import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../constant/db_keys.dart';
import '../enum/status.dart';
import '../enum/transaction_view_type.dart';
import '../model/transaction.dart';
import '../repository/transaction_repository.dart';
import '../util/date_util.dart';
import 'base_controller.dart';

class TransactionsController extends BaseController {
  TransactionsController({
    @required this.transactionRepository,
  });

  final TransactionRepository transactionRepository;

  TextEditingController searchController = TextEditingController();

  /// Holds the data for the list of transactions
  ///
  List<Transaction> _transactions = <Transaction>[];

  /// Holds the data for the list of filtered transactions
  ///
  List<Transaction> _filteredTransactions = <Transaction>[];

  /// Holds the data for the total amount expenses
  ///
  double totalAmount = 0.0;

  /// Holds the data for the selected viewing type either [day] or [month]
  ///
  TransactionViewType _transactionViewType = TransactionViewType.day;

  /// Holds the data for the selected date
  ///
  DateTime _selectedDate = DateTime.now();

  /// Holds the data if the [_selectedDate] is current day or current month
  ///
  bool isCurrentDate = true;

  // Methods -------------------------------------------------------------------------
  //
  //

  Future<void> search(String text) async {
    final List<Transaction> transactions = <Transaction>[];
    final String query = text.toLowerCase();
    for (final Transaction transaction in _transactions) {
      if (transaction.remarks.toLowerCase().contains(query) ||
          transaction.account.title.toLowerCase().contains(query) ||
          transaction.amount.toString().contains(query)) {
        transactions.add(transaction);
      }
    }

    filteredTransaction = text.isEmpty ? _transactions : transactions;
    update();
  }

  void setTotalAmount(){
    double total = 0.0;
    for(final Transaction transaction in filteredTransaction){
      total +=transaction.amount;
    }
    totalAmount = total;
  }

  /// Get unmodifiable [_filteredTransactions]
  ///
  ///
  UnmodifiableListView<Transaction> get filteredTransaction =>
      UnmodifiableListView<Transaction>(_filteredTransactions);

  set filteredTransaction(List<Transaction> transactions) {
    _filteredTransactions = transactions;
    setTotalAmount();
  }

  /// A setter for [_transactions]
  ///
  set transactions(List<Transaction> transactions){
    _transactions = transactions;
    filteredTransaction = _transactions;
  }

  /// Initialize transaction list
  ///
  ///
  Future<void> getTransactionList() async {
    status = Status.LOADING;
    transactions = await transactionRepository.getTransactions(
      where: '${DBKey.UPDATED_AT} between ? and ?',
      whereArgs: _getWhereArgs(),
    ) ??
        <Transaction>[];
    status = Status.COMPLETED;
  }

  /// A getter for [_transactionViewType]
  ///
  TransactionViewType get transactionViewType => _transactionViewType;

  /// A setter for [_transactionViewType]
  ///
  /// It will set [isCurrentDate].
  /// It will fetch transaction list
  ///
  set transactionViewType(TransactionViewType viewType) {
    _transactionViewType = viewType;
    setIsCurrentDate();
    getTransactionList();
  }

  /// Check and return true if [_selectedDate] is a current date
  /// and [_transactionViewType] is equals [TransactionViewType.day]
  ///
  bool get isCurrentDay {
    final DateTime dateNow = DateTime.now();
    final DateTime selected =
        DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
    final DateTime currentDate =
        DateTime(dateNow.year, dateNow.month, dateNow.day);

    return selected.isAtSameMomentAs(currentDate) &&
        _transactionViewType == TransactionViewType.day;
  }

  /// Set is [isCurrentDate]
  ///
  void setIsCurrentDate() {
    final DateTime dateNow = DateTime.now();
    final DateTime selectedDate =
        DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);

    DateTime currentDate;
    if (_transactionViewType == TransactionViewType.day) {
      currentDate = DateTime(dateNow.year, dateNow.month, dateNow.day);
    } else {
      currentDate = DateTime(dateNow.year, dateNow.month, 01);
    }

    if (selectedDate.isBefore(currentDate)) {
      isCurrentDate = false;
    } else {
      isCurrentDate = true;
    }
  }

  /// A getter for [_selectedDate]
  ///
  DateTime get selectedDate => _selectedDate;

  /// A setter for [_selectedDate]
  ///
  /// It will set [isCurrentDate].
  /// It will fetch transaction list
  ///
  set selectedDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
    setIsCurrentDate();
    getTransactionList();
  }

  /// View today's transactions
  /// This will set [_transactionViewType] into [TransactionViewType.day]
  ///
  void viewTodayTransaction() {
    _transactionViewType = TransactionViewType.day;
    selectedDate = DateTime.now();
  }

  /// Retrieve previous date.
  /// It will trigger to fetch the list of transactions
  ///
  void previous() {
    if (_transactionViewType == TransactionViewType.day) {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day - 1,
      );
    } else {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month - 1,
        selectedDate.day,
      );
    }
  }

  /// Retrieve next date.
  /// It will trigger to fetch the list of transactions
  ///
  void next() {
    if (_transactionViewType == TransactionViewType.day) {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day + 1,
      );
    } else {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month + 1,
        selectedDate.day,
      );
    }
  }


  /// Generate where args according to [_selectedDate]
  /// and [_transactionViewType]
  ///
  List<dynamic> _getWhereArgs() {
    final List<String> whereArgs = <String>[];
    if (_transactionViewType == TransactionViewType.day) {
      whereArgs.add('${_selectedDate.year.toString()}'
          '-${_selectedDate.month.toString().padLeft(2, '0')}'
          '-${_selectedDate.day.toString().padLeft(2, '0')}'
          ' 00:00:00');
      whereArgs.add('${_selectedDate.year.toString()}'
          '-${_selectedDate.month.toString().padLeft(2, '0')}'
          '-${_selectedDate.day.toString().padLeft(2, '0')}'
          ' 23:59:59');
    } else {
      whereArgs.add('${_selectedDate.year.toString()}'
          '-${_selectedDate.month.toString().padLeft(2, '0')}'
          '-01 00:00:00');
      whereArgs.add('${_selectedDate.year.toString()}'
          '-${_selectedDate.month.toString().padLeft(2, '0')}'
          '-31 23:59:59');
    }
    return whereArgs;
  }

  /// Update specific transaction from list
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

    filteredTransaction = _transactions;
    update();
  }

  /// Get title
  /// This will display into the appbar
  ///
  String getTitle() {
    if (_transactionViewType == TransactionViewType.day) {
      return '${getFullMonth(_selectedDate.month)} '
          '${_selectedDate.day.toString().padLeft(2, '0')}, '
          '${selectedDate.year}';
    } else {
      return '${getFullMonth(_selectedDate.month)}  ${selectedDate.year}';
    }
  }

  /// Get currency name
  ///
  String getCurrency() => settingsProvider.settings.currency.name;
}
