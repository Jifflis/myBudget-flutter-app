import '../constant/db_keys.dart';
import '../model/account.dart';
import '../model/currency.dart';
import '../model/settings.dart';
import '../model/user.dart';
import 'local_provider.dart';
import 'resource_definition.dart';

class ResourceHelper {
  String tag = 'resource_helper';

  static final List<ResourceDefinition> _resources = <ResourceDefinition>[
    ResourceDefinition(
      type: Account,
      builder: (
        Map<String, dynamic> json,
        LocalProvider localProvider,
      ) => Account(json: json),
      name: DBKey.ACCOUNT,
      toMap: (Account account) => account.toJson(),
    ),
    ResourceDefinition(
      type: Settings,
      builder: (
        Map<String, dynamic> json,
        LocalProvider localProvider,
      ) async {
        final User user = await localProvider.get<User>(
          where: '${DBKey.USER_ID} =?',
          whereArgs: <String>[json[DBKey.USER_ID]],
        );

        final Currency currency = await localProvider.get<Currency>(
            where: '${DBKey.CURRENCY_ID} = ?',
            whereArgs: <String>[json[DBKey.CURRENCY_ID]]);

        final Settings settings = Settings(json: json);
        settings.user = user;
        settings.currency = currency;
        return settings;
      },
      name: DBKey.SETTINGS,
      toMap: (Settings settings) => settings.toJson(),
    ),
    ResourceDefinition(
      type: User,
      builder: (
        Map<String, dynamic> json,
        LocalProvider localProvider,
      ) => User(json: json),
      name: DBKey.USER,
      toMap: (User user) => user.toJson(),
    ),
    ResourceDefinition(
      type: Currency,
      builder: (
        Map<String, dynamic> json,
        LocalProvider localProvider,
      ) => Currency(json: json),
      name: DBKey.CURRENCY,
      toMap: (Currency currency) => currency.toJson(),
    ),
  ];

  static ResourceDefinition get<T>() => _resources
      .singleWhere((ResourceDefinition resource) => resource.type == T);
}
