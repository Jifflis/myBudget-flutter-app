import 'dart:ui';

import 'package:flutter/material.dart';

class UtilityUI {
  static void addBudgetConfirmation(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 350,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.purple[600],
                    size: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Success!',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Account has been saved!',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.grey,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {},
                        color: Colors.purple[800],
                        textColor: Colors.white,
                        child: Text('Ok'),
                      ),
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  static void addTransactionConfirmation(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 450,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.purple[600],
                    size: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Success!',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Apartment Rental',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.grey,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Amount 300',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.grey,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Remarks:Apartment Payment',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.grey,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {},
                        color: Colors.purple[800],
                        textColor: Colors.white,
                        child: Text('Close'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {},
                        color: Colors.purple[800],
                        textColor: Colors.white,
                        child: Text('Add Another'),
                      ),
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}
