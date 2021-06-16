import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mybudget/constant/general.dart';
import 'package:oktoast/oktoast.dart';

import '../controller/base_controller.dart';
import '../enum/status.dart';
import '../model/account.dart';
import '../model/transaction.dart';
import '../repository/acount_repository.dart';
import '../repository/transaction_repository.dart';
import '../util/id_util.dart';

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
  DateTime _selectedDate = DateTime.now();
  List<Account> _accountList = <Account>[];
  Account _selectedAccount;

  /// get data [_selectedDate]
  ///
  ///
  DateTime get selectedDate => _selectedDate;

  /// set data [_selectedData]
  ///
  ///
  set selectedDate(DateTime dateTime) {
    _selectedDate = dateTime;
    update();
  }

  /// get params
  ///
  ///
  Future<void> getParams(Account account) async {
    status = Status.LOADING;
    _accountList = await accountRepository.getAccounts();

    if (account != null) {
      for (final Account element in _accountList) {
        if (element.accountId == account.accountId) {
          selectedAccount = element;
        }
      }
    } else {
      selectedAccount = _accountList.first;
    }

    status = Status.COMPLETED;
  }

  /// save transaction
  ///
  ///
  Future<bool> save() async {
    if(remarksController.text==SYSTEM_GEN){
      showToast('Invalid remarks!');
      return false;
    }

    if (formKey.currentState.validate()) {
      final Transaction transaction = Transaction(
        transactionID: randomID(),
        userID: userProvider.user.userId,
        accountID: selectedAccount.accountId,
        remarks: remarksController.text,
        amount: double.parse(amountController.text),
        date: selectedDate,
      );

      transactionRepository.upsert(transaction);

      // update account
      selectedAccount.expense += double.parse(amountController.text);
      selectedAccount.balance =
          selectedAccount.budget - selectedAccount.expense;
      await accountRepository.upsert(selectedAccount);

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
    _selectedDate = DateTime.now();
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

  @override
  void onClose() {
    super.onClose();
    amountController.dispose();
    remarksController.dispose();
  }
}
