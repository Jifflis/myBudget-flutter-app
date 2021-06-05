import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/budget_dialog_widget.dart';

void showBudgetDialog({
  @required BuildContext context,
  String title = '',
  String description,
  String button1Title,
  String button2Title,
  bool showButton1 = true,
  bool showButton2 = true,
  Function onButton1Press,
  Function onButton2Press,
  bool barrierDismissible = true,
}) {
  showGeneralDialog(
    barrierLabel: 'Budget Dialog',
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black.withOpacity(0.5),
    useRootNavigator: false,
    context: context,
    transitionBuilder: (_, __, ___, ____) => Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Align(
            alignment: Alignment.center,
            child: WillPopScope(
              onWillPop: () async {
                return barrierDismissible;
              },
              child: BudgetDialog(
                title: title,
                description: description,
                button1Title: button1Title,
                button2Title: button2Title,
                showButton1: showButton1,
                showButton2: showButton2,
                onButton1Press: onButton1Press,
                onButton2Press: onButton2Press,
              ),
            )),
      ),
    ),
    transitionDuration: const Duration(milliseconds: 100),
    pageBuilder: (_, __, ___) => Container(),
  );
}
