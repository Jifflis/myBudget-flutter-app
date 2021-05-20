import 'package:mybudget/constant/db_keys.dart';

enum FilterType {
  month,
  day,
  year,
  account,
  remarks,
}

extension FilterTypeExtension on FilterType{
  String get dbValue {
    switch(this){
      case FilterType.month:
        return DBKey.MONTH;
      case FilterType.day:
        return DBKey.UPDATED_AT;
      case FilterType.year:
        return DBKey.YEAR;
      case FilterType.account:
        return DBKey.ACCOUNT_ID;
      case FilterType.remarks:
        return DBKey.REMARKS;
      default:
        return 'unknown';
    }
  }
}