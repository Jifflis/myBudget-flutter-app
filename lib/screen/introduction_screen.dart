import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mybudget/System/utility.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final enteredOTP = TextEditingController();
  String currencyValue = 'PH';

  //Currenct
  static const PH = 'PH';
  static const EURO = 'EURO';

  List<DropdownMenuItem<String>> _currencyItems = [
    DropdownMenuItem(value: PH, child: Text(PH)),
    DropdownMenuItem(value: EURO, child: Text(EURO))
  ];

  Widget dropDownDesign(
      List<DropdownMenuItem<String>> items, String value, Function onChanged) {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 5, 40, 50),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey[300].withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 4), // changes position of shadow
        ),
      ]),
      // margin: EdgeInsets.all(40),
      padding: EdgeInsets.only(left: 15, right: 15),
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: value,
          onChanged: onChanged,
          items: items,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.purple[800],
        child: SafeArea(
          child: Stack(
            children: [
              //HEADER
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Icon(
                              Icons.ac_unit,
                              size: 50,
                              color: Colors.white,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'myBudget',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                  ],
                ),
              ),

              //BODY
              Container(
                margin: EdgeInsets.only(top: 80),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(40),
                            child: Text(
                              'Welcome!',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20),
                          //Currency list
                          Container(
                            margin: EdgeInsets.only(left: 40),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: new Text("Set currency",
                                    style: TextStyle(color: Colors.grey))),
                          ),
                          dropDownDesign(_currencyItems, currencyValue,
                              (value) {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            setState(() {
                              currencyValue = value;
                            });
                          }),
                          Container(
                            margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                            child: ButtonTheme(
                              minWidth: double.infinity,
                              height: 50,
                              child: RaisedButton(
                                onPressed: () {
                                  // showDialog();
                                  UtilityUI.addTransactionConfirmation(context);
                                },
                                color: Colors.purple[800],
                                textColor: Colors.white,
                                child: Text('Ok'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
