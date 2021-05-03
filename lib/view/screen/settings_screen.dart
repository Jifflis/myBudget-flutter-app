import 'package:flutter/material.dart';

import '../../routes.dart';
import '../dialog/filter_dialog.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Routes.pushNamed(Routes.SCREEN_INTRODUCTION,
                    navigator: Routes.settingsNavigator);
              },
              child: const Text('show introduction'),
            ),
            const SizedBox(
              height: 45,
            ),
            GestureDetector(
              onTap: () {
                showFilterDialog(context);
              },
              child: const Text('show filter dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
