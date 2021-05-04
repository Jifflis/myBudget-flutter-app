import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybudget/routes.dart';
import 'package:oktoast/oktoast.dart';

import 'resources/local_db.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorKey: Routes.rootNavigatorKey,
        initialRoute: Routes.SCREEN_INITIAL,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}
