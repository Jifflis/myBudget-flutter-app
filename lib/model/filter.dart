import '../enum/filter_type.dart';

class Filter implements Comparable<Filter> {
  Filter(this.name, this.type);

  final String name;
  final FilterType type;

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
}
