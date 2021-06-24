import '../constant/db_keys.dart';
import '../constant/general.dart';
import '../enum/transaction_type.dart';
import '../model/account.dart';
import '../model/filter.dart';
import '../model/transaction.dart';
import '../model/user.dart';
import '../resources/local_provider.dart';
import '../util/id_util.dart';
import 'transaction_repository.dart';

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

  Future<List<Account>> getAccountsWithFiltr(List<Filter> filters) async {
    final Map<String, dynamic> filter = Filter.generateFilter(filters);

    if (filter == null) {
      return <Account>[];
    }

    return await _localProvider.list<Account>(
        where: filter['where'],
        whereArgs: filter['whereArgs'],
        orderBy: 'id desc');
  }

  Future<List<Account>> getAccounts() async {
    return await _localProvider.list<Account>(orderBy: 'id desc');
  }

  Future<Account> getAccount(String accountID) async {
    return await _localProvider.get<Account>(
      where: DBKey.ACCOUNT_ID,
      whereArgs: <dynamic>[accountID],
    );
  }

  Future<void> monthlyRefresh(
    String oldMonthlySummaryID,
    String newMonthlySummaryID,
    User user,
    TransactionRepository transactionRepository,
  ) async {
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

        //A transaction
        final Transaction transaction = Transaction(
          transactionID: randomID(),
          userID: user.userId,
          accountID: account.accountId,
          remarks: SYSTEM_GEN,
          amount: account.expense,
          date: DateTime.now(),
          transactionType: TransactionType.expense.valueString,
        );
        transactionRepository.upsert(transaction);
      }
      await upsert(account);
    }
  }
}
