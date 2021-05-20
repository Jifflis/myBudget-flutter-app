import 'dart:collection';

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

  List<Transaction> _transactions = <Transaction>[];

  TransactionViewType _transactionViewType = TransactionViewType.day;

  DateTime _selectedDate = DateTime.now();
  bool isCurrentDate= true;


  TransactionViewType get transactionViewType => _transactionViewType;

  set transactionViewType(TransactionViewType viewType) {
    _transactionViewType = viewType;
    setIsCurrentDate();
    getTransactionList();
  }


  void setIsCurrentDate(){
    final DateTime dateNow = DateTime.now();
    final DateTime selectedDate = DateTime(_selectedDate.year,_selectedDate.month,_selectedDate.day);

    DateTime currentDate;
    if (_transactionViewType == TransactionViewType.day) {
      currentDate = DateTime(dateNow.year,dateNow.month,dateNow.day);
    }else{
      currentDate = DateTime(dateNow.year,dateNow.month,01);
    }

    if(selectedDate.isBefore(currentDate)){
      isCurrentDate = false;
    }else{
      isCurrentDate = true;
    }
  }

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
    setIsCurrentDate();
    getTransactionList();
  }

  /// get unmodifiable [_transactions]
  ///
  ///
  UnmodifiableListView<Transaction> get transactions =>
      UnmodifiableListView<Transaction>(_transactions);

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

  /// initialize transaction list
  ///
  ///
  Future<void> getTransactionList() async {
    status = Status.LOADING;
    _transactions = await transactionRepository.getTransactions(
          where: '${DBKey.UPDATED_AT} between ? and ?',
          whereArgs: _getWhereArgs(),
        ) ??
        <Transaction>[];
    status = Status.COMPLETED;
  }

  /// generate where args according to [_selectedDate]
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
          ' 11:59:59');
    } else {
      whereArgs.add('${_selectedDate.year.toString()}'
          '-${_selectedDate.month.toString().padLeft(2, '0')}'
          '-01 00:00:00');
      whereArgs.add('${_selectedDate.year.toString()}'
          '-${_selectedDate.month.toString().padLeft(2, '0')}'
          '-31 11:59:59');
    }
    return whereArgs;
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

  String getTitle() {
    if (_transactionViewType == TransactionViewType.day) {
      return '${getFullMonth(_selectedDate.month)} '
          '${_selectedDate.day.toString().padLeft(2, '0')}, '
          '${selectedDate.year}';
    } else {
      return '${getFullMonth(_selectedDate.month)}  ${selectedDate.year}';
    }
  }

  String getCurrency() => settingsProvider.settings.currency.name;
}
