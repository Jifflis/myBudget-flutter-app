import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybudget/view/widget/image_selector_widget.dart';

void showImageSelectorDialog({
  @required BuildContext context,
  @required String imageName,
  @required Function(String) callbackPath,
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
          child: ImageSelectorWidget(
            imageName: imageName,
            callbackPath: callbackPath,),
        ),
      ),
    ),
    transitionDuration: const Duration(milliseconds: 100),
    pageBuilder: (_, __, ___) => Container(),
  );
}
