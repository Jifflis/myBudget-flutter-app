
import 'package:flutter_test/flutter_test.dart';
import 'package:mybudget/util/date_util.dart';

void main(){
  group('Date util test',(){

    test('should return June 30 2021',(){
      final DateTime expectedDate = DateTime(2021,06,30);
      expect(getNextMonthLastDate(DateTime(2021,05,31)),expectedDate);
    });

    test('should return January 31 2022',(){
      final DateTime expectedDate = DateTime(2022,01,31);
      expect(getNextMonthLastDate(DateTime(2021,12,31)),expectedDate);
    });
  });
}