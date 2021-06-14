import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../constant/db_keys.dart';
import 'account.dart';
import 'base_model.dart';

class Transaction extends BaseModel {
  Transaction({
    @required this.transactionID,
    @required this.userID,
    @required this.accountID,
    @required this.remarks,
    @required this.amount,
    this.date,
    this.title,
    this.account,
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
  DateTime date;
  double amount;
  Account account;

  @override
  void fromJson(Map<String, dynamic> json) {
    transactionID = json[DBKey.TRANSACTION_ID];
    userID = json[DBKey.USER_ID];
    accountID = json[DBKey.ACCOUNT_ID];
    remarks = json[DBKey.REMARKS]?.toString();
    amount = json[DBKey.AMOUNT];
    createdAt = DateTime.parse(json[DBKey.CREATED_AT]);
    updatedAT = DateTime.parse(json[DBKey.UPDATED_AT]);

    //add transaction date
    if (json[DBKey.TRANSACTION_DATE] == null ||
        json[DBKey.TRANSACTION_DATE].toString().isEmpty) {
      date = updatedAT;
    } else {
      date = DateTime.parse(json[DBKey.TRANSACTION_DATE]);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map[DBKey.TRANSACTION_ID] = transactionID;
    map[DBKey.USER_ID] = userID;
    map[DBKey.ACCOUNT_ID] = accountID;
    map[DBKey.REMARKS] = remarks;
    map[DBKey.AMOUNT] = amount;
    map[DBKey.CREATED_AT] = DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAt);
    map[DBKey.UPDATED_AT] = DateFormat('yyyy-MM-dd HH:mm:ss').format(updatedAT);
    map[DBKey.TRANSACTION_DATE] = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    return map;
  }
}
