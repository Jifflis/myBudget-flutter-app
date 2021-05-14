import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';

import '../model/account.dart';
import '../repository/acount_repository.dart';
import '../util/id_util.dart';
import 'base_controller.dart';

class AddBudgetController extends BaseController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController accountController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final AccountRepository _accountRepository = AccountRepository();

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
  Future<void> save() async {
    if (formKey.currentState.validate()) {
      final Account account = Account(
          summaryId: monthlySummaryID(),
          accountId: randomID(),
          title: accountController.text,
          budget: double.parse(amountController.text),
          balance: double.parse(amountController.text),
          autoDeduct: isAutoDeduct,
          userId: userProvider.user.userId);

      if (isAutoDeduct) {
        account.expense = account.budget;
        account.balance = 0.0;
      }

      await _accountRepository.upsert(account);

      showToast('Budget account successfully added',
          position: ToastPosition.bottom);
      resetFields();
    }
  }

  Future<void> getList() async {
    final List<Account> accounts = await _accountRepository.getAccounts();

    accounts.forEach(print);
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
