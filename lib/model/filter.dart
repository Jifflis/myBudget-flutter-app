import 'package:intl/intl.dart';

import '../constant/db_keys.dart';
import '../enum/filter_type.dart';

class Filter implements Comparable<Filter> {
  Filter(this.name, this.type, {this.key = 'null'});

  final String name;
  final FilterType type;
  final String key;

  /// Return the order by [FilterType]
  ///
  int getOrder() {
    switch (type) {
      case FilterType.month:
        return 1;
      case FilterType.day:
        return 2;
      case FilterType.year:
        return 3;
      case FilterType.account:
        return 4;
      case FilterType.remarks:
        return 5;
      default:
        return 5;
    }
  }

  static List<Filter> defaultFilter() {
    final DateTime dateNow = DateTime.now();
    return <Filter>[
      Filter(dateNow.day.toString(), FilterType.day),
      Filter(DateFormat.MMMM().format(dateNow), FilterType.month,
          key: dateNow.month.toString()),
      Filter(dateNow.year.toString(), FilterType.year),
    ];
  }

  ///param [filters] should have a type of [FilterType.month] and [FilterType.year]
  ///otherwise it will return null;
  ///
  static Map<String, dynamic> generateFilter(List<Filter> filters) {
    //check null or length is less than 2
    if (filters == null || filters.length < 2) {
      return null;
    }

    //sort filter
    filters.sort();

    //check if filters contains  FilterType.month
    if (filters[0].type != FilterType.month) {
      return null;
    }

    //check if filters contains  FilterType.year
    final Filter filter = filters.firstWhere(
        (Filter element) => element.type == FilterType.year,
        orElse: () => null);
    if (filter == null) {
      return null;
    }

    final Map<String, dynamic> map = <String, dynamic>{};
    final List<String> whereArgs = <String>[];
    final bool containsDay = filters[1].type == FilterType.day;
    String where = '';

    where += '${DBKey.UPDATED_AT} between ? and ?';

    if (containsDay) {
      whereArgs.add(
          '${filters[2].name.padLeft(2, '0')}-${filters[0].key.padLeft(2, '0')}-${filters[1].name.padLeft(2, '0')} 00:00:00');
      whereArgs.add(
          '${filters[2].name.padLeft(2, '0')}-${filters[0].key.padLeft(2, '0')}-${filters[1].name.padLeft(2, '0')} 11:59:59');
    } else {
      whereArgs.add(
          '${filters[1].name.padLeft(2, '0')}-${filters[0].key.padLeft(2, '0')}-01 00:00:00');
      whereArgs.add(
          '${filters[1].name.padLeft(2, '0')}-${filters[0].key.padLeft(2, '0')}-31 11:59:59');
    }

    for (final Filter filter in filters) {
      if (filter.type == FilterType.month ||
          filter.type == FilterType.day ||
          filter.type == FilterType.year) {
        continue;
      }

      where += ' and ${filter.type.dbValue} = ?';
      whereArgs.add(filter.key);
    }

    map['where'] = where;
    map['whereArgs'] = whereArgs;
    return map;
  }

  @override
  int compareTo(dynamic filter) {
    if (getOrder() < filter.getOrder()) {
      return -1;
    }
    if (getOrder() > filter.getOrder()) {
      return 1;
    }
    return 0;
  }

  @override
  String toString() {
    return 'Filter{name: $name, type: $type, key: $key}';
  }
}
