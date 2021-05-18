import 'package:mybudget/model/transaction.dart';

import '../constant/db_keys.dart';
import '../model/account.dart';
import '../model/currency.dart';
import '../model/monthly_summary.dart';
import '../model/settings.dart';
import '../model/user.dart';
import '../util/id_util.dart';
import 'local_provider.dart';
import 'resource_definition.dart';

class ResourceHelper {
  String tag = 'resource_helper';

  static final List<ResourceDefinition> _resources = <ResourceDefinition>[
    ResourceDefinition(
      type: Transaction,
      builder: (
        Map<String, dynamic> json,
        LocalProvider localProvider,
      ) async {
        final Account account = await localProvider.get<Account>(
          where: '${DBKey.ACCOUNT_ID}=?',
          whereArgs: <dynamic>[
            json[DBKey.ACCOUNT_ID],
          ],
        );
        return Transaction(
          transactionID: null,
          userID: null,
          accountID: null,
          title: null,
          remarks: null,
          amount: null,
          account: account,
          json: json,
        );
      },
      name: DBKey.TRANSACTION,
      toMap: (Transaction transaction) => transaction.toJson(),
    ),
    ResourceDefinition(
      type: Account,
      builder: (
        Map<String, dynamic> json,
        LocalProvider localProvider,
      ) =>
          Account(
              json: json,
              accountId: null,
              summaryId: null,
              userId: null,
              title: null),
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

        final Settings settings = Settings(json: json);
        settings.user = user;
        settings.currency = Currency(
          currencyID: json[DBKey.CURRENCY_ID],
          name: json[DBKey.CURRENCY_ID],
        );
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
      ) =>
          User(json: json),
      name: DBKey.USER,
      toMap: (User user) => user.toJson(),
    ),
    ResourceDefinition(
      type: Currency,
      builder: (
        Map<String, dynamic> json,
        LocalProvider localProvider,
      ) =>
          Currency(json: json),
      name: DBKey.CURRENCY,
      toMap: (Currency currency) => currency.toJson(),
    ),
    ResourceDefinition(
      type: MonthlySummary,
      builder: (
        Map<String, dynamic> json,
        LocalProvider localProvider,
      ) async {
        final List<Account> accounts = await localProvider.list<Account>(
          where: '${DBKey.MONTHLY_SUMMARY_ID}=?',
          whereArgs: <dynamic>[
            json[DBKey.MONTHLY_SUMMARY_ID] ?? monthlySummaryID(),
          ],
        );

        final MonthlySummary summary = MonthlySummary(json: json);
        summary.accountList = accounts;

        return summary;
      },
      name: DBKey.MONTHLY_SUMMARY,
      toMap: (MonthlySummary summary) => summary.toJson(),
    ),
  ];

  static ResourceDefinition get<T>() => _resources
      .singleWhere((ResourceDefinition resource) => resource.type == T);
}
