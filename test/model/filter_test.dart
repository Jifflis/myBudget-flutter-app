import 'package:flutter_test/flutter_test.dart';
import 'package:mybudget/constant/db_keys.dart';
import 'package:mybudget/enum/filter_type.dart';
import 'package:mybudget/model/filter.dart';

void main() {
  group('Filter Model', () {
    group('Generate Filter', () {
      
      test('test with filter type day', () {
        final List<Filter> filters = <Filter>[
          Filter('2021', FilterType.year, key: '05'),
          Filter('May', FilterType.month, key: '05'),
          Filter('01', FilterType.day, key: '05'),
          Filter('House Bill', FilterType.account, key: '0531'),
        ];

        final Map<String, dynamic> generatedFilter =
            Filter.generateFilter(filters);
        final List<String> whereArgs = generatedFilter['whereArgs'];

        expect(whereArgs[0], '2021-05-01 00:00:00');
        expect(whereArgs[1], '2021-05-01 11:59:59');
        expect(whereArgs[2], '0531');
        expect(generatedFilter['where'],
            '${DBKey.UPDATED_AT} between ? and ? and ${DBKey.ACCOUNT_ID} = ?');
      });

      test('test without filter type day', () {
        final List<Filter> filters = <Filter>[
          Filter('2021', FilterType.year, key: '05'),
          Filter('May', FilterType.month, key: '05'),
          Filter('Remark', FilterType.remarks, key: 'bayad'),
          Filter('House Bill', FilterType.account, key: '0102'),
        ];

        final Map<String, dynamic> generatedFilter =
            Filter.generateFilter(filters);
        final List<String> whereArgs = generatedFilter['whereArgs'];

        expect(whereArgs[0], '2021-05-01 00:00:00');
        expect(whereArgs[1], '2021-05-31 11:59:59');
        expect(whereArgs[2], '0102');
        expect(whereArgs[3], 'bayad');

        expect(generatedFilter['where'],
            '${DBKey.UPDATED_AT} between ? and ? and ${DBKey.ACCOUNT_ID} = ? and ${DBKey.REMARKS} = ?');
      });
    });
  });
}
