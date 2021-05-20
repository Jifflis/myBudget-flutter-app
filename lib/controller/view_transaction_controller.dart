import 'package:flutter/material.dart';
import 'package:mybudget/util/number_util.dart';
import '../controller/base_controller.dart';
import '../model/account.dart';
import '../model/transaction.dart';
import '../repository/acount_repository.dart';
import '../repository/transaction_repository.dart';

class ViewTransactionController extends BaseController {
  ViewTransactionController({
    @required this.transactionRepository,
    @required this.accountRepository,
  });
  final TransactionRepository transactionRepository;
  final AccountRepository accountRepository;

  bool _isFieldEnabled = false;
  Transaction _transaction;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  /// get data [_selectedDate]
  ///
  ///
  DateTime get selectedDate => _selectedDate;

  /// set data [_selectedDate]
  ///
  ///
  set selectedDate(DateTime dateTime) {
    _selectedDate = dateTime;
    update();
  }

  /// get params
  ///
  ///
  void getParams(Transaction transaction) {
    _transaction = transaction;
    titleController.text = transaction.account.title;
    amountController.text = transaction.amount.toString();
    _selectedDate = transaction.updatedAT;
    remarksController.text = transaction.remarks;
  }

  /// get data [_transaction]
  ///
  ///
  Transaction get transaction => _transaction;

  /// set data [_isFieldEnabled]
  ///
  ///
  set isEnabled(bool isEnabled) {
    _isFieldEnabled = isEnabled;
    update();
  }

  /// get data [_isFieldEnabled]
  ///
  ///
  bool get isEnabled => _isFieldEnabled;

  /// update transaction
  ///
  ///
  Future<bool> updateTransaction() async {
    if (formKey.currentState.validate()) {
      final double difference =
          double.parse(amountController.text) - _transaction.amount;
      _transaction.amount = double.parse(amountController.text);
      _transaction.remarks = remarksController.text;
      _transaction.updatedAT = selectedDate;
      transactionRepository.upsert(transaction);

      final Account account = _transaction.account;
      account.expense += difference;
      account.balance = account.budget - account.expense;
      accountRepository.upsert(account);

      return true;
    }
    return false;
  }

  /// delete transaction
  ///
  ///
  Future<void> deleteTransaction() async {
    final Account account = _transaction.account;
    account.expense -= _transaction.amount;
    account.balance = account.budget - account.expense;
    accountRepository.upsert(account);
    await transactionRepository.delete(_transaction.transactionID);
  }

  /// Text form field validator
  ///
  ///
  String textFieldValidator(String value) {
    if (value == null || value.isEmpty) {
      return 'Empty value is invalid.';
    }
    return null;
  }

  /// reset fields
  ///
  ///
  Future<void> resetFields() async {
    isEnabled = false;
  }

  TextEditingController formattedAmount() {
    if (!isEnabled) {
      amountController.text = amountFormatter(
          double.parse(amountController.text.replaceAll(',', '')));
    } else {
      amountController.text = amountController.text.replaceAll(',', '');
    }

    return amountController;
  }

  @override
  void onClose() {
    super.onClose();
    titleController.dispose();
    amountController.dispose();
    remarksController.dispose();
  }
}
