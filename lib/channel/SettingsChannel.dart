import 'package:flutter/services.dart';

class SettingsChannel{
  factory SettingsChannel() =>_instance;
  SettingsChannel._();
  
  static final SettingsChannel _instance = SettingsChannel._();
  
  static const String ACTION_TO_CHECK_DATE_SETTINGS = 'ACTION_TO_CHECK_DATE_SETTINGS';
  static const String ACTION_TO_GO_TO_SETTINGS = 'ACTION_TO_GO_TO_SETTINGS';

  static const String _CHANNEL = 'com.sakayta.mybudget/settings';
  final MethodChannel _platform = const MethodChannel(_CHANNEL);
  
  Future<int> isNetworkProvidedTime() async{
    int result;
    try{
      result = await _platform.invokeMethod(ACTION_TO_CHECK_DATE_SETTINGS);
    }on PlatformException{
      result =  1;
    }
    return result;
  }

  Future<void> gotoToDateSettings() async {
    try{
      await _platform.invokeMethod(ACTION_TO_GO_TO_SETTINGS);
    }catch(e){
      print(e.toString());
    }
  }
}