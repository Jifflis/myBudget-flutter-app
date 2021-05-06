import '../constant/db_keys.dart';
import 'currency.dart';
import 'user.dart';

class Settings {
  Settings({
    this.settingsId,
    this.firstInstall,
    this.refreshDate,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.currency,
    Map<String, dynamic> json,
  }) {
    if (json != null) {
      fromJson(json);
    }
  }

  String settingsId;
  bool firstInstall;
  DateTime refreshDate;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  Currency currency;

  void fromJson(Map<String, dynamic> json) {
    settingsId = json[DBKey.SETTINGS_ID];
    if (json[DBKey.FIRST_INSTALL] == null) {
      firstInstall = true;
    } else {
      if (json[DBKey.FIRST_INSTALL] == 0) {
        firstInstall = false;
      } else {
        firstInstall = true;
      }
    }
    refreshDate = DateTime.tryParse(json[DBKey.REFRESH_DATE]);
    createdAt = DateTime.tryParse(json[DBKey.CREATED_AT]);
    updatedAt = DateTime.tryParse(json[DBKey.UPDATED_AT]);
    user = json[DBKey.USER] != null ? User(json: json[DBKey.USER]) : null;
    currency = json[DBKey.CURRENCY] != null
        ? Currency(json: json[DBKey.CURRENCY])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map[DBKey.SETTINGS_ID] = settingsId;
    map[DBKey.FIRST_INSTALL] = firstInstall?1:0;
    map[DBKey.REFRESH_DATE] = refreshDate.toString();
    map[DBKey.CREATED_AT] = createdAt.toString();
    map[DBKey.UPDATED_AT] = updatedAt.toString();
    map[DBKey.USER_ID] = user?.userId;
    map[DBKey.CURRENCY_ID] = currency?.currencyID;
    return map;
  }

  @override
  String toString() {
    return 'Settings{settingsId: $settingsId, firstInstall: $firstInstall, refreshDate: $refreshDate, createdAt: $createdAt, updatedAt: $updatedAt, user: $user, currency: $currency}';
  }
}
