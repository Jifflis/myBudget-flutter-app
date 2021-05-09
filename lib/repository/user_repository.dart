import '../model/user.dart';
import '../resources/local_provider.dart';

class UserRepository {
  factory UserRepository() => _instance;

  UserRepository._();

  static final UserRepository _instance = UserRepository._();

  final LocalProvider _localProvider = LocalProvider();

  Future<void> upsert(User user) async {
    await _localProvider.upsert<User>(user);
  }

  Future<User> getUser()async{
    return await _localProvider.get<User>();
  }
}
