import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:oktoast/oktoast.dart';

import '../model/account.dart';
import '../repository/acount_repository.dart';
import '../util/number_util.dart';

class ViewBudgetController extends GetxController {
  bool _isFieldEnabled = false;
  bool _isAutoDeduct = false;
  Account _account;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController budgetAmountController = TextEditingController();

  final AccountRepository _accountRepository = AccountRepository();

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
    update();
  }

  /// get data [_isAutoDeduct]
  ///
  bool get isAutoDeduct => _isAutoDeduct;

  /// get params from route
  ///
  void getParams(Account account) {
    _account = account;
    accountNameController.text = account.title;
    budgetAmountController.text = amountFormatter(account.budget);
    isAutoDeduct = account.autoDeduct;
  }

  /// update budget account
  ///
  Future<void> updateAccount() async {
    if (isEnabled && formKey.currentState.validate()) {
      _account.title = accountNameController.text;
      _account.budget = double.parse(budgetAmountController.text);
      _account.autoDeduct = isAutoDeduct;
      _account.balance = _account.budget - _account.expense;

      if (isAutoDeduct) {
        _account.expense = _account.budget;
        _account.balance = 0.0;
      }

      await _accountRepository.upsert(_account);

      showToast('Budget account successfully updated',
          position: ToastPosition.bottom);
      isEnabled = !isEnabled;
    }
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
}
