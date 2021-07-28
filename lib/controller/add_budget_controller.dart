import 'package:flutter/cupertino.dart';

import '../constant/general.dart';
import '../enum/transaction_type.dart';
import '../exception/failure.dart';
import '../model/account.dart';
import '../model/transaction.dart';
import '../repository/acount_repository.dart';
import '../repository/transaction_repository.dart';
import '../util/id_util.dart';
import 'base_controller.dart';

class AddBudgetController extends BaseController {
  AddBudgetController(
    this._accountRepository,
    this._transactionRepository,
  );

  final AccountRepository _accountRepository;
  final TransactionRepository _transactionRepository;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController accountController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  bool _isAutoDeduct = false;

  /// get data [_isAutoDeduct]
  ///
  bool get isAutoDeduct => _isAutoDeduct;

  /// set data [_isAutoDeduct]
  ///
  set isAutoDeduct(bool val) {
    _isAutoDeduct = val;
    update();
  }

  /// Save account
  ///
  ///
  Future<bool> save(Account account) async {
    if (await _accountRepository.getAccountByName(account.title) != null) {
      throw Failure('Account already exist');
    }

    if (isAutoDeduct) {
      account.expense = account.budget;
      account.balance = 0.0;

      //Add system generated transaction
      await _transactionRepository
          .upsert(getSystemGeneratedTransaction(account));
    }

    await _accountRepository.upsert(account);
    return true;
  }

  /// Create account object
  ///
  Account getAccount() {
    return Account(
        summaryId: monthlySummaryID(),
        accountId: randomID(),
        title: accountController.text,
        budget: double.parse(amountController.text),
        balance: double.parse(amountController.text),
        autoDeduct: isAutoDeduct,
        userId: userProvider.user.userId);
  }

  /// Create a system generated transaction
  ///
  Transaction getSystemGeneratedTransaction(Account account) {
    return Transaction(
      transactionID: randomID(),
      userID: userProvider?.user?.userId,
      accountID: account.accountId,
      remarks: SYSTEM_GEN,
      amount: account.expense,
      transactionType: TransactionType.expense.valueString,
      date: DateTime.now(),
    );
  }

  /// Reset fields
  ///
  ///
  void resetFields() {
    accountController.clear();
    amountController.clear();
    isAutoDeduct = false;
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
