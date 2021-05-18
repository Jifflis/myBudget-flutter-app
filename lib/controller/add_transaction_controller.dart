import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mybudget/controller/base_controller.dart';
import 'package:mybudget/enum/status.dart';
import 'package:mybudget/model/transaction.dart';
import 'package:mybudget/repository/acount_repository.dart';
import 'package:mybudget/repository/transaction_repository.dart';
import 'package:mybudget/util/id_util.dart';

import '../model/account.dart';

class AddTransactionController extends BaseController {
  AddTransactionController({
    @required this.transactionRepository,
    @required this.accountRepository,
  });
  final TransactionRepository transactionRepository;
  final AccountRepository accountRepository;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Account> _accountList = <Account>[];
  Account _selectedAccount;

  /// get params
  ///
  ///
  Future<void> getParams(Account account) async {
    status = Status.LOADING;
    _accountList = await accountRepository.getAccounts();

    for (final Account element in _accountList) {
      if (element.accountId == account.accountId) {
        selectedAccount = element;
      }
    }
    status = Status.COMPLETED;
  }

  /// save transaction
  ///
  ///
  bool save() {
    if (formKey.currentState.validate()) {
      final Transaction transaction = Transaction(
          transactionID: randomID(),
          userID: userProvider.user.userId,
          accountID: selectedAccount.accountId,
          remarks: remarksController.text,
          amount: double.parse(amountController.text));
      transactionRepository.upsert(transaction);
      resetFields();
      return true;
    }
    return false;
  }

  /// reset fields
  ///
  ///
  void resetFields() {
    amountController.clear();
    remarksController.clear();
  }

  /// get unmodified [accountList]
  ///
  ///
  UnmodifiableListView<Account> get accountList =>
      UnmodifiableListView<Account>(_accountList);

  /// get data [_selectedAccount]
  ///
  ///
  Account get selectedAccount => _selectedAccount;

  /// set data [_selectedAccount]
  ///
  ///
  set selectedAccount(Account account) {
    _selectedAccount = account;
    update();
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
}
