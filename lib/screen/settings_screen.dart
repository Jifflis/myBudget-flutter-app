import 'package:flutter/material.dart';

import '../routes.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              Routes.pushNamed(Routes.SCREEN_INTRODUCTION);
            },
            child: Text('Settings Screen'),
          ),
        ],
      ),
    );
  }
}
