import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/filter_widget.dart';

void showFilterDialog(BuildContext context,Function onOk) {
  showGeneralDialog(
    barrierLabel: 'Filter',
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    useRootNavigator: false,
    context: context,
    transitionBuilder: (_, __, ___, ____) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Align(
        alignment: Alignment.center,
        child: FilterWidget(onOk),
      ),
    ),
    transitionDuration: const Duration(milliseconds: 100),
    pageBuilder: (_, __, ___) => Container(),
  );
}
