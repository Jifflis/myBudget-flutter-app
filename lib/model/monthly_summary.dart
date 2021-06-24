import '../constant/db_keys.dart';
import 'account.dart';
import 'base_model.dart';

class MonthlySummary extends BaseModel {
  MonthlySummary({
    this.monthlySummaryId,
    this.accountList,
    this.budget = 0.0,
    this.balance = 0.0,
    this.expense = 0.0,
    this.adjusted = 0.0,
    this.income = 0.0,
    this.year,
    this.month,
    this.userId,
    DateTime createdAt,
    DateTime updateAt,
    Map<String, dynamic> json,
    List<String> notIncludeInMapping,
  }) : super(
          json: json,
          createdAt: createdAt,
          updatedAT: updateAt,
          notIncludeInMapping: notIncludeInMapping,
        );

  List<Account> accountList;
  String monthlySummaryId;
  int month;
  int year;
  double budget;
  double expense;
  double balance;
  double adjusted;
  double income;
  String userId;

  @override
  void fromJson(Map<String, dynamic> json) {
    monthlySummaryId = json[DBKey.MONTHLY_SUMMARY_ID];
    month = json[DBKey.MONTH];
    year = json[DBKey.YEAR];
    budget = json[DBKey.BUDGET];
    expense = json[DBKey.EXPENSE];
    balance = json[DBKey.BALANCE];
    adjusted = json[DBKey.ADJUSTED];
    createdAt = DateTime.tryParse(json[DBKey.CREATED_AT] ?? 'null');
    updatedAT = DateTime.tryParse(json[DBKey.UPDATED_AT] ?? 'null');
    userId = json[DBKey.USER_ID];

    //set income
    if (json[DBKey.INCOME] == null ||
        json[DBKey.INCOME].toString().isEmpty) {
      income = 0.0;
    }else{
      income = json[DBKey.INCOME];
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json[DBKey.MONTHLY_SUMMARY_ID] = monthlySummaryId;
    json[DBKey.MONTH] = month;
    json[DBKey.YEAR] = year;
    json[DBKey.BUDGET] = budget;
    json[DBKey.EXPENSE] = expense;
    json[DBKey.BALANCE] = balance;
    json[DBKey.ADJUSTED] = adjusted;
    json[DBKey.INCOME] = income;
    json[DBKey.CREATED_AT] = createdAt?.toString();
    json[DBKey.UPDATED_AT] = updatedAT?.toString();
    json[DBKey.USER_ID] = userId;
    return filterToJson(json);
  }

  @override
  String toString() {
    return 'MonthlySummary{accountList: $accountList, monthlySummaryId: $monthlySummaryId, month: $month, year: $year, budget: $budget, expense: $expense, balance: $balance, adjusted: $adjusted, createdAT: $createdAt, updatedAT: $updatedAT ,accounts ${accountList?.toString()}';
  }
}
