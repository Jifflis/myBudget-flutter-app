import 'package:flutter/material.dart';

import '../controller/base_controller.dart';
import '../enum/transaction_type.dart';
import '../model/account.dart';
import '../model/transaction.dart';
import '../repository/acount_repository.dart';
import '../repository/transaction_repository.dart';
import '../util/number_util.dart';

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
  TransactionType _transactionType = TransactionType.expense;

  /// A getter for [_transactionViewType]
  ///
  TransactionType get transactionType => _transactionType;

  /// A setter for [_transactionType]
  ///
  set transactionType(TransactionType transactionType) {
    _transactionType = transactionType;
    update();
  }

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
    _selectedDate = transaction.date;
    remarksController.text = transaction.remarks;

    if (transaction.transactionType == TransactionType.income.valueString) {
      _transactionType = TransactionType.income;
    } else {
      _transactionType = TransactionType.expense;
    }
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
    final double difference =
        double.parse(amountController.text) - _transaction.amount;

    final Transaction originalTransaction = Transaction(
      transactionID: null,
      userID: null,
      accountID: null,
      remarks: null,
      amount: _transaction.amount,
      transactionType: _transaction.transactionType,
    );

    _transaction.amount = double.parse(amountController.text);
    _transaction.remarks = remarksController.text;
    _transaction.updatedAT = DateTime.now();
    _transaction.date = selectedDate;
    _transaction.transactionType = _transactionType.valueString;
    transactionRepository.upsert(transaction);

    final Account account = _transaction.account;
    //if there is no changes in transaction type
    //and transaction type is equal to expense.
    if (originalTransaction.transactionType ==
            TransactionType.expense.valueString &&
        originalTransaction.transactionType == _transaction.transactionType) {
      account.expense += difference;
    }
    //if there is no changes in transaction type
    //and transaction type is equal to income.
    if (originalTransaction.transactionType ==
            TransactionType.income.valueString &&
        originalTransaction.transactionType == _transaction.transactionType) {
      account.income += difference;
    }
    //if there's changes in transaction type
    //and the changes is from expense to income
    if (originalTransaction.transactionType ==
            TransactionType.expense.valueString &&
        originalTransaction.transactionType != _transaction.transactionType) {
      account.expense -= originalTransaction.amount;
      account.income += _transaction.amount;
    }
    //if there's changes in transaction type
    //and the changes is from income to expense
    if (originalTransaction.transactionType ==
            TransactionType.income.valueString &&
        originalTransaction.transactionType != _transaction.transactionType) {
      account.income -= originalTransaction.amount;
      account.expense += _transaction.amount;
    }
    account.balance = account.budget - account.expense;
    accountRepository.upsert(account);

    return true;
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
