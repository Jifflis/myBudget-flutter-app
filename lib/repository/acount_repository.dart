
import '../model/account.dart';
import '../resources/api_provider.dart';
import '../resources/local_provider.dart';

class AccountRepository{

  AccountRepository._();

  static AccountRepository _instance;

  final LocalProvider _localProvider = LocalProvider();

  static AccountRepository getInstance(){
    if(_instance==null){
      return AccountRepository._();
    }
    return _instance;
  }

  Future<void> save(Account account)async{
    await _localProvider.upsert<Account>(account);
  }

}