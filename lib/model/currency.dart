import 'package:mybudget/constant/db_keys.dart';

class Currency {
  Currency({
    this.currencyID,
    this.name,
    this.symbol,
    Map<String, dynamic> json,
  }) {
    if (json != null) {
      fromJson(json);
    }
  }

  String currencyID;
  String name;
  String symbol;

  void fromJson(Map<String, dynamic> map) {
    currencyID = map[DBKey.CURRENCY_ID];
    name = map[DBKey.NAME];
    symbol = map[DBKey.SYMBOL];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map[DBKey.CURRENCY_ID] = currencyID;
    map[DBKey.NAME] = name;
    map[DBKey.SYMBOL] = symbol;
    return map;
  }

  @override
  String toString() {
    return 'Currency{currencyID: $currencyID, name: $name, symbol: $symbol}';
  }
}
