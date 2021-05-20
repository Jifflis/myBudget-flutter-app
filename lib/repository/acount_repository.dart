import 'package:mybudget/util/id_util.dart';

import '../constant/db_keys.dart';
import '../model/account.dart';
import '../resources/local_provider.dart';

class AccountRepository {
  factory AccountRepository() => _instance;

  AccountRepository._();

  static final AccountRepository _instance = AccountRepository._();

  final LocalProvider _localProvider = LocalProvider();

  Future<void> upsert(Account account) async {
    await _localProvider.upsert<Account>(account);
  }

  Future<void> delete(String accountID) async {
    await _localProvider.delete<Account>(
        where: '${DBKey.ACCOUNT_ID}=?', whereArgs: <dynamic>[accountID]);
  }

  Future<List<Account>> getAccounts() async {
    return await _localProvider.list<Account>();
  }

  Future<Account> getAccount(String accountID) async {
    return await _localProvider.get<Account>(
      where: DBKey.ACCOUNT_ID,
      whereArgs: <dynamic>[accountID],
    );
  }

  Future<void> monthlyRefresh(
      String oldMonthlySummaryID, String newMonthlySummaryID) async {
    final List<Account> previousAccounts = await _localProvider.list<Account>(
        where: '${DBKey.MONTHLY_SUMMARY_ID}=?',
        whereArgs: <dynamic>[oldMonthlySummaryID]);

    for (final Account account in previousAccounts) {
      account.accountId = randomID();
      account.balance = account.budget;
      account.expense = 0.0;
      account.summaryId = newMonthlySummaryID;

      if (account.autoDeduct) {
        account.expense = account.budget;
        account.balance = 0.0;
      }
      await upsert(account);
    }
  }
}
