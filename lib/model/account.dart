import 'package:mybudget/util/id_util.dart';

import '../constant/db_keys.dart';
import 'base_model.dart';
import 'user.dart';

class Account extends BaseModel {
  Account({
    this.accountId,
    this.title,
    this.budget=0.0,
    this.expense=0.0,
    this.balance=0.0,
    this.adjusted,
    this.autoDeduct = false,
    this.user,
    DateTime createdAt,
    DateTime updatedAT,
    Map<String, dynamic> json,
  }) : super(
          json: json,
          createdAt: createdAt,
          updatedAT: updatedAT,
        );

  String accountId;
  String title;
  double budget;
  double expense;
  double balance;
  double adjusted;
  bool autoDeduct;
  User user;

  @override
  void fromJson(Map<String, dynamic> json) {
    accountId = json[DBKey.ACCOUNT_ID];
    title = json[DBKey.TITLE];
    budget = json[DBKey.BUDGET];
    expense = json[DBKey.EXPENSE];
    balance = json[DBKey.BALANCE];
    autoDeduct = json[DBKey.AUTO_DEDUCT] != 0;
    adjusted = json[DBKey.ADJUSTED];
    createdAt = DateTime.parse(json[DBKey.CREATED_AT]);
    updatedAT = DateTime.parse(json[DBKey.UPDATED_AT]);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map[DBKey.ACCOUNT_ID] = accountId;
    map[DBKey.TITLE] = title;
    map[DBKey.BUDGET] = budget;
    map[DBKey.EXPENSE] = expense;
    map[DBKey.BALANCE] = balance;
    map[DBKey.ADJUSTED] = adjusted;
    map[DBKey.AUTO_DEDUCT] = autoDeduct ? 1 : 0;
    map[DBKey.CREATED_AT] = createdAt.toString();
    map[DBKey.UPDATED_AT] = updatedAT.toString();
    map[DBKey.USER_ID] = user?.userId;
    map[DBKey.MONTHLY_SUMMARY_ID] = monthlySummaryID();
    return map;
  }

  @override
  String toString() {
    return 'Account{accountId: $accountId, title: $title, budget: $budget, expense: $expense, balance: $balance, adjusted: $adjusted, autoDeduct: $autoDeduct, user: $user}';
  }
}
