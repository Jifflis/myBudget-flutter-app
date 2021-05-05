import '../model/user.dart';
import '../resources/local_provider.dart';

class UserRepository {
  UserRepository._();

  static UserRepository _instance;

  static UserRepository get instance => _instance ?? UserRepository._();

  final LocalProvider _localProvider = LocalProvider();

  Future<void> upsert(User user) async {
    await _localProvider.upsert<User>(user);
  }
}
