import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mybudget/view/widget/budget_button.dart';

void showImageSelectorDialog({
  @required BuildContext context,
  @required Function cancel,
  @required Function save,
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
          child: ImageSelectorWidget(),
        ),
      ),
    ),
    transitionDuration: const Duration(milliseconds: 100),
    pageBuilder: (_, __, ___) => Container(),
  );
}

class ImageSelectorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const MethodChannel platform = MethodChannel('com.sakayta.mybudget/image');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 40),
      margin: const EdgeInsets.symmetric(vertical: 17, horizontal: 17),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // image
          const SizedBox(height: 20),
          imageViewer(),
          // row option
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              imageOption(
                label: 'Camera',
                icon: Icons.camera_alt,
                onPressed: () async {
                  await platform.invokeMethod('showCamera');
                },
              ),
              imageOption(
                label: 'Gallery',
                icon: Icons.image,
                onPressed: () async {
                  await platform.invokeMethod('showGallery');
                },
              ),
            ],
          ),
          // save
          const SizedBox(height: 30),
          BudgetButton(() {}, 'Save'),
          // cancel
          const SizedBox(height: 10),
          BudgetButton(() {}, 'Cancel'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget imageViewer() => Container(
        height: 200,
        width: 200,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
            color: Colors.purple,
            style: BorderStyle.solid,
          ),
        ),
        child: const Text(
          'No Image',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.purple,
          ),
        ),
      );

  Widget imageOption({
    @required String label,
    @required IconData icon,
    @required Function onPressed,
  }) =>
      InkWell(
        onTap: onPressed,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(color: Colors.purple),
              ),
              child: Icon(
                icon,
                size: 50,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.purple,
              ),
            )
          ],
        ),
      );
}
