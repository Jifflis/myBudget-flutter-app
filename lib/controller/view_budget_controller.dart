import 'package:flutter/material.dart';

import '../constant/general.dart';
import '../enum/transaction_type.dart';
import '../model/account.dart';
import '../model/transaction.dart';
import '../repository/acount_repository.dart';
import '../repository/transaction_repository.dart';
import '../util/id_util.dart';
import '../util/number_util.dart';
import 'base_controller.dart';

class ViewBudgetController extends BaseController {
  ViewBudgetController(
    this._accountRepository,
    this._transactionRepository,
  );

  final AccountRepository _accountRepository;
  final TransactionRepository _transactionRepository;

  bool _isFieldEnabled = false;
  bool _isAutoDeduct = false;
  Account _account;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController budgetAmountController = TextEditingController();

  Account get account =>_account;

  /// set data [_isFieldEnabled]
  ///
  set isEnabled(bool isEnabled) {
    _isFieldEnabled = isEnabled;
    update();
  }

  /// get data [_isFieldEnabled]
  ///
  bool get isEnabled => _isFieldEnabled;

  /// set data [_isAutoDeduct]
  ///
  set isAutoDeduct(bool val) {
    _isAutoDeduct = val;
    print(_isAutoDeduct);
    update();
  }

  /// get data [_isAutoDeduct]
  ///
  bool get isAutoDeduct => _isAutoDeduct;

  /// get params from route
  ///
  void initAccount(Account account) {
    _account = account;
    accountNameController.text = account.title;
    budgetAmountController.text = amountFormatter(account.budget);
    _isAutoDeduct = account.autoDeduct;
  }

  /// update budget account
  ///
  Future<bool> updateAccount() async {
    if (!isEnabled && !formKey.currentState.validate()) {
      return false;
    }

    final Account currentAccount = Account(
        accountId: _account.accountId,
        title: _account.title,
        summaryId: _account.summaryId,
        userId: _account.userId,
        budget: _account.budget,
        autoDeduct: _account.autoDeduct,
        expense: _account.expense);

    _account.title = accountNameController.text;
    _account.budget = double.parse(budgetAmountController.text);
    _account.autoDeduct = _isAutoDeduct;
    _account.balance = _account.budget - _account.expense;

    if (isAutoDeduct) {
      _account.expense = _account.budget;
      _account.balance = 0.0;

      // Delete all transaction under this account
      await _transactionRepository.deleteAll(_account.accountId);

      // Add system generated transaction
      final Transaction transaction = Transaction(
        transactionID: randomID(),
        userID: userProvider.user.userId,
        accountID: _account.accountId,
        remarks: SYSTEM_GEN,
        amount: _account.budget,
        transactionType: TransactionType.expense.valueString,
        date: DateTime.now(),
      );
      _transactionRepository.upsert(transaction);
    } else {
      _account.expense = _account.expense -
          (currentAccount.autoDeduct ? currentAccount.budget : 0);
      _account.balance = _account.budget - _account.expense;
      await _transactionRepository
          .deleteSystemGeneratedTransaction(_account.accountId);
    }

    await _accountRepository.upsert(_account);

    print('the budget:${_account.budget}');
    isEnabled = !isEnabled;
    return true;
  }

  /// edit | cancel text button
  ///
  ///
  Future<void> edit() async {
    isEnabled = !isEnabled;
  }

  TextEditingController formattedBudgetAmount() {
    if (!isEnabled) {
      budgetAmountController.text = amountFormatter(
          double.parse(budgetAmountController.text.replaceAll(',', '')));
    } else {
      budgetAmountController.text =
          budgetAmountController.text.replaceAll(',', '');
    }

    return budgetAmountController;
  }

  /// reset page
  ///
  ///
  Future<void> resetPage() async {
    isEnabled = false;
  }

  /// delete update account
  ///
  ///
  Future<void> deleteAccount() async {
    await _accountRepository.delete(_account.accountId);
    await _transactionRepository.deleteAll(_account.accountId);
    update();
  }

  /// text form field validator
  ///
  ///
  String textFieldValidator(String value) {
    if (value == null || value.isEmpty) {
      return 'Empty value is invalid.';
    }
    return null;
  }

  @override
  void onClose() {
    super.onClose();
    accountNameController.dispose();
    budgetAmountController.dispose();
  }
}
