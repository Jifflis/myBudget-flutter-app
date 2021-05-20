import '../enum/filter_type.dart';
import '../model/filter.dart';

class Month {}

class Day {}

class Year {}

List<Filter> monthsFilter = <Filter>[
  Filter('January', FilterType.month,key: '01'),
  Filter('February', FilterType.month,key: '02'),
  Filter('March', FilterType.month,key: '03'),
  Filter('April', FilterType.month,key: '04'),
  Filter('May', FilterType.month,key: '05'),
  Filter('June', FilterType.month,key: '06'),
  Filter('July', FilterType.month,key: '07'),
  Filter('August', FilterType.month,key: '08'),
  Filter('September', FilterType.month,key: '09'),
  Filter('October', FilterType.month,key: '10'),
  Filter('November', FilterType.month,key: '11'),
  Filter('December', FilterType.month,key: '12'),
];

List<Filter> daysFilter = <Filter>[
  Filter('01', FilterType.day),
  Filter('02', FilterType.day),
  Filter('03', FilterType.day),
  Filter('04', FilterType.day),
  Filter('05', FilterType.day),
  Filter('06', FilterType.day),
  Filter('07', FilterType.day),
  Filter('08', FilterType.day),
  Filter('09', FilterType.day),
  Filter('10', FilterType.day),
  Filter('11', FilterType.day),
  Filter('12', FilterType.day),
  Filter('13', FilterType.day),
  Filter('14', FilterType.day),
  Filter('15', FilterType.day),
  Filter('16', FilterType.day),
  Filter('17', FilterType.day),
  Filter('18', FilterType.day),
  Filter('19', FilterType.day),
  Filter('20', FilterType.day),
  Filter('22', FilterType.day),
  Filter('23', FilterType.day),
  Filter('24', FilterType.day),
  Filter('25', FilterType.day),
  Filter('26', FilterType.day),
  Filter('27', FilterType.day),
  Filter('28', FilterType.day),
  Filter('29', FilterType.day),
  Filter('30', FilterType.day),
  Filter('31', FilterType.day),
];

List<Filter> yearsFilter = <Filter>[
  Filter('2021', FilterType.year),
  Filter('2022', FilterType.year),
  Filter('2023', FilterType.year),
  Filter('2024', FilterType.year),
  Filter('2025', FilterType.year),
];

List<Filter> searchFilters<T>(String keyword) {
  if (keyword == null || keyword.trim().isEmpty) {
    return <Filter>[];
  }

  final List<Filter> searchResult = <Filter>[];
  List<Filter> source;

  switch (T) {
    case Month:
      source = monthsFilter;
      break;
    case Day:
      source = daysFilter;
      break;
    default:
      source = yearsFilter;
  }

  for (final Filter filter in source) {
    if (filter.name.toLowerCase().contains(keyword.toLowerCase())) {
      searchResult.add(filter);
    }
  }
  return searchResult;
}
