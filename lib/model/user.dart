import 'package:mybudget/constant/db_keys.dart';
import 'package:mybudget/util/id_util.dart';

class User {
  User({
    this.userId,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
    Map<String, dynamic> json,
  }) {
    if (json != null) {
      fromJson(json);
    }
  }

  String userId;
  String name;
  String email;
  String password;
  DateTime createdAt;
  DateTime updatedAt;

  static User factory(){
    return User(
      userId: randomID(),
      name: 'user',
      email: '',
      password: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  void fromJson(Map<String, dynamic> json) {
    userId = json[DBKey.USER_ID];
    name = json[DBKey.NAME];
    email = json[DBKey.EMAIL];
    password = json[DBKey.PASSWORD];
    createdAt = DateTime.tryParse(json[DBKey.CREATED_AT]);
    updatedAt = DateTime.tryParse(json[DBKey.UPDATED_AT]);
  }

  Map<String, dynamic> toJson() {
    final Map<String,dynamic> json = <String,dynamic>{};
    json[DBKey.USER_ID] = userId;
    json[DBKey.NAME] = name;
    json[DBKey.EMAIL] = email;
    json[DBKey.PASSWORD] = password;
    json[DBKey.CREATED_AT] = createdAt.toString();
    json[DBKey.UPDATED_AT] = updatedAt.toString();
    return json;
  }

  @override
  String toString() {
    return 'User{userId: $userId, name: $name, email: $email, password: $password, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
