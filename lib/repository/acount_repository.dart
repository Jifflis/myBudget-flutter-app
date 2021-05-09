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
}
