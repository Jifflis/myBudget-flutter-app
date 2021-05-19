import 'package:flutter/material.dart';
import 'package:mybudget/controller/base_controller.dart';
import 'package:mybudget/model/account.dart';
import 'package:mybudget/model/transaction.dart';
import 'package:mybudget/repository/acount_repository.dart';
import 'package:mybudget/repository/transaction_repository.dart';
import 'package:mybudget/util/date_util.dart';

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
  final TextEditingController dateController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  /// get params
  ///
  ///
  void getParams(Transaction transaction) {
    _transaction = transaction;
    titleController.text = transaction.account.title;
    amountController.text = transaction.amount.toString();
    final Map<String, dynamic> dateObj =
        dateSimplified(transaction.updatedAT.toString());
    dateController.text =
        '${dateObj['MM']} ${dateObj['DD']}, ${dateObj['YYYY']}';
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

  @override
  void onClose() {
    super.onClose();
    titleController.dispose();
    dateController.dispose();
    amountController.dispose();
    remarksController.dispose();
  }
}
