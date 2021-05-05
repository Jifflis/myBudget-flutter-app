import '../model/account.dart';
import '../resources/local_provider.dart';

class AccountRepository {
  AccountRepository._();

  static AccountRepository _instance;

  final LocalProvider _localProvider = LocalProvider();

  static AccountRepository get instance => _instance ?? AccountRepository._();

  Future<void> save(Account account) async {
    await _localProvider.upsert<Account>(account);
  }
}
