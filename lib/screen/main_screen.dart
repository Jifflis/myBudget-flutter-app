import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybudget/constant/custom_colors.dart';

import '../controller/main_controller.dart';
import '../routes.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> _navigationScreens = <Widget>[
    SubNavigator(
        navigatorKey: Routes.intorNavitorKey,
        initialRoute: Routes.SCREEN_INTRODUCTION),
    SubNavigator(
        navigatorKey: Routes.homeNavigatorKey,
        initialRoute: Routes.SCREEN_HOME),
    SubNavigator(
      navigatorKey: Routes.transactionNavigatorKey,
      initialRoute: Routes.SCREEN_TRANSACTIONS,
    ),
    SubNavigator(
        navigatorKey: Routes.settingsNavigatorKey,
        initialRoute: Routes.SCREEN_SETTINGS),
  ];

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.put(MainController());
    return Obx(
      () => Scaffold(
        body: _navigationScreens[controller.selectedBottomIndex.value],
        bottomNavigationBar: _buildBottomNavigation(context, controller),
      ),
    );
  }

  /// Build bottom navigation widget.
  ///
  ///
  Widget _buildBottomNavigation(
          BuildContext context, MainController controller) =>
      BottomNavigationBar(
        backgroundColor: CustomColors.gray11,
        elevation: 10,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: CustomColors.violet,
        unselectedItemColor: Colors.grey,
        currentIndex: controller.selectedBottomIndex.value,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.selectedBottomIndex.value = index;
        },
        items: _bottomNavigationItems(),
      );

  /// Bottom navigation items.
  ///
  ///
  List<BottomNavigationBarItem> _bottomNavigationItems() =>
      <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Icon(
              Icons.home_outlined,
              size: 19,
            ),
          ),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Icon(
              Icons.list_alt,
              size: 19,
            ),
          ),
          label: 'Transaction',
        ),
        const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Icon(
              Icons.settings,
              size: 19,
            ),
          ),
          label: 'Settings',
        ),
      ];
}
