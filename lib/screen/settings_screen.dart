import 'package:flutter/material.dart';

import '../routes.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Routes.pushNamed(Routes.SCREEN_INTRODUCTION);
            },
            child: const Text('Settings Screen'),
          ),
        ],
      ),
    );
  }
}
