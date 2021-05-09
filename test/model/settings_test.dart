import 'package:flutter_test/flutter_test.dart';
import 'package:mybudget/constant/db_keys.dart';
import 'package:mybudget/model/settings.dart';

void main(){

  group('Settings Model',(){

    final Map<String,dynamic> json = <String,dynamic>{
      DBKey.SETTINGS_ID:'id',
      DBKey.REFRESH_DATE:'2020-01-01',
      DBKey.CREATED_AT:'2020-02-01',
      DBKey.UPDATED_AT:'2020-02-01k',
      DBKey.USER:null,
      DBKey.CURRENCY:null,
    };
    final Settings settings = Settings(json: json);

    test('should parse json to model',(){
      expect(settings.settingsId,json[DBKey.SETTINGS_ID]);
      expect(settings.refreshDate,DateTime.tryParse(json[DBKey.REFRESH_DATE]));
      expect(settings.createdAt,DateTime.tryParse(json[DBKey.CREATED_AT]));
      expect(settings.settingsId,json[DBKey.SETTINGS_ID]);
      expect(settings.updatedAt,DateTime.tryParse(json[DBKey.UPDATED_AT]));
      expect(settings.user,json[DBKey.USER]);
      expect(settings.currency,json[DBKey.CURRENCY]);
    });

    test('should convert model to json',(){
      final Map<String,dynamic> json = settings.toJson();
      expect(json[DBKey.SETTINGS_ID],settings.settingsId);
      expect(json[DBKey.REFRESH_DATE],settings.refreshDate.toString());
      expect(json[DBKey.CREATED_AT],settings.createdAt.toString());
      expect(json[DBKey.SETTINGS_ID],settings.settingsId);
      expect(json[DBKey.UPDATED_AT],settings.updatedAt.toString());
      expect(json[DBKey.USER_ID],null);
      expect(json[DBKey.CURRENCY_ID],null);
    });
  });

}