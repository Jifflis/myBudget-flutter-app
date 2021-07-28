import 'dart:convert';

import 'package:flutter/services.dart';

import 'dart_defines.dart';


class Env {

  String tag = 'env';

  static Map<String, dynamic> _env;
  static String _envType;


  static Future<void> init() async{
    final Map<String,dynamic> env = json.decode(await rootBundle.loadString('.env'));
    final String flavor = DartDefines.flavor;
    _env = env[flavor];
    print('the env');
    print(_env['tag']);
  }

  static Future<void> initEnv() async {
    _env = json.decode(await rootBundle.loadString('.env'));
    _envType = _env['environment'];
    await init();
  }

  /// Get API Url.
  ///
  ///
  static String get apiUrl => _env[_envType]['apiUrl'];

  /// Get maintenance URL IOS.
  ///
  ///
  static String get maintenanceUrlIOS => _env[_envType]['maintenance_url_ios'];

  /// Get maintenance URL ANDROID.
  ///
  ///
  static String get maintenanceUrlAndroid=>_env[_envType]['maintenance_url_android'];
}
