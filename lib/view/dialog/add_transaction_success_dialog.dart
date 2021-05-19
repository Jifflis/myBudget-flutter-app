import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybudget/view/widget/add_transaction_success_widget.dart';

void showAddTransactionSuccessDialog({
  @required BuildContext context,
  @required Function close,
  @required Function addAnother,
  @required String title,
  @required String amount,
  @required String remarks,
}) {
  showGeneralDialog(
    barrierLabel: 'Filter',
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    useRootNavigator: true,
    context: context,
    transitionBuilder: (_, __, ___, ____) => Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Align(
          alignment: Alignment.center,
          child: AddTransactionSuccessWidget(
            close: close,
            addAnother: addAnother,
            title: title,
            amount: amount,
            remarks: remarks,
          ),
        ),
      ),
    ),
    transitionDuration: const Duration(milliseconds: 100),
    pageBuilder: (_, __, ___) => Container(),
  );
}
