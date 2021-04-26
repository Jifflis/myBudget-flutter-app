
import '../model/account.dart';
import '../resources/api_provider.dart';
import '../resources/local_provider.dart';

class AccountRepository{

  AccountRepository._(){
    apiProvider = ApiProvider();
    localProvider = LocalProvider();
  }

  static AccountRepository _instance;

  ApiProvider apiProvider;
  LocalProvider localProvider;

  static AccountRepository getInstance(){
    if(_instance==null){
      return AccountRepository._();
    }
    return _instance;
  }

  Future<void> save(Account account)async{
    await localProvider.upsert<Account>(account);
  }

}