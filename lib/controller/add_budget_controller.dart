import 'package:flutter/cupertino.dart';

import '../model/account.dart';
import '../repository/acount_repository.dart';
import '../repository/monthly_repository.dart';
import '../util/id_util.dart';
import 'base_controller.dart';

class AddBudgetController extends BaseController {
  TextEditingController accountController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final AccountRepository _accountRepository = AccountRepository();
  final MonthlySummaryRepository _monthlySummaryRepository =
      MonthlySummaryRepository();

  Future<void> save() async {
    final Account account = Account(
        summaryId: monthlySummaryID(),
        accountId: randomID(),
        title: accountController.text,
        budget: double.parse(amountController.text),
        balance: double.parse(amountController.text),
        userId: userProvider.user.userId);
    await _accountRepository.upsert(account);
    await _monthlySummaryRepository.updateMonthlySummary();
  }

  Future<void> getList() async {
    final List<Account> accounts = await _accountRepository.getAccounts();

    accounts.forEach(print);
  }
}
