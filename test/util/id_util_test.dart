import 'package:flutter_test/flutter_test.dart';
import 'package:mybudget/util/id_util.dart';

void main() {
  group('Id_util_test', () {
    group('monthlySummaryID', () {
      test('should return 5-2021', () {
        const String expected = '5-2021';
        expect(monthlySummaryID(date: DateTime(2021, 05, 03)), expected);
      });

      test('should return today\'s month id', () {
        final String expected =
            '${DateTime.now().month}-${DateTime.now().year}';
        expect(monthlySummaryID(), expected);
      });
    });
  });
}
