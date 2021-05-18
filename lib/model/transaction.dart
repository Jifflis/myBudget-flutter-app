import 'package:meta/meta.dart';
import 'package:mybudget/constant/db_keys.dart';
import 'package:mybudget/model/base_model.dart';

class Transaction extends BaseModel {
  Transaction({
    @required this.transactionID,
    @required this.userID,
    @required this.accountID,
    @required this.remarks,
    @required this.amount,
    this.date,
    this.title,
    DateTime createdAt,
    DateTime updatedAT,
    Map<String, dynamic> json,
    List<String> notIncludeInMapping,
  }) : super(
          notIncludeInMapping: notIncludeInMapping,
          json: json,
          createdAt: createdAt,
          updatedAT: updatedAT,
        );

  String transactionID;
  String title;
  String userID;
  String accountID;
  String remarks;
  String date;
  double amount;

  @override
  void fromJson(Map<String, dynamic> json) {
    transactionID = json[DBKey.TRANSACTION_ID];
    userID = json[DBKey.USER_ID];
    accountID = json[DBKey.ACCOUNT_ID];
    remarks = json[DBKey.REMARKS];
    amount = json[DBKey.AMOUNT];
    createdAt = DateTime.parse(json[DBKey.CREATED_AT]);
    updatedAT = DateTime.parse(json[DBKey.UPDATED_AT]);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map[DBKey.TRANSACTION_ID] = transactionID;
    map[DBKey.USER_ID] = userID;
    map[DBKey.ACCOUNT_ID] = accountID;
    map[DBKey.REMARKS] = remarks;
    map[DBKey.AMOUNT] = amount;
    map[DBKey.CREATED_AT] = createdAt.toString();
    map[DBKey.UPDATED_AT] = updatedAT.toString();
    return map;
  }
}
