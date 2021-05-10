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

  Future<List<Account>> getAccounts() async {
    return await _localProvider.list<Account>();
  }

  Future<void> monthlyRefresh(
      String oldMonthlySummaryID, String newMonthlySummaryID) async {
    final List<Account> previousAccounts = await _localProvider.list<Account>(
        where: '$DBKey.MONTHLY_SUMMARY_ID=?',
        whereArgs: <dynamic>[oldMonthlySummaryID]);

    for (final Account account in previousAccounts) {
      account.balance = account.budget;
      account.expense = 0;
      account.summaryId = newMonthlySummaryID;
      await upsert(account);
    }
  }
}
