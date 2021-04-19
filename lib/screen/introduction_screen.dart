import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybudget/controller/currenct_controller.dart';
import 'package:mybudget/model/currency.dart';

class IntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          _getLeadingIcon(),
          _getTitle(),
        ),
        body: IntroductionBody());
  }

  /// set app bar
  ///
  ///
  Widget appBar(
    Icon leading,
    String title,
  ) {
    return AppBar(
      backgroundColor: Colors.purple[800],
      title: Text(title),
      leading: leading,
      elevation: 0,
    );
  }

  ///get appbar leading icon
  ///
  ///
  Widget _getLeadingIcon() {
    return Icon(
      Icons.ac_unit,
      color: Colors.purple[100],
      size: 32,
    );
  }

  /// get appbar title
  ///
  ///
  String _getTitle() {
    return 'myBudget';
  }
}

class IntroductionBody extends StatefulWidget {
  @override
  _IntroductionBodyState createState() => _IntroductionBodyState();
}

class _IntroductionBodyState extends State<IntroductionBody> {
  final enteredOTP = TextEditingController();
  String currencyValue = 'PH';

  //Currenct
  static const PH = 'PH';
  static const EURO = 'EURO';

  List<DropdownMenuItem<String>> _currencyItems = [
    DropdownMenuItem(value: PH, child: Text(PH)),
    DropdownMenuItem(value: EURO, child: Text(EURO))
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.purple[800],
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 8),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: Column(
            children: [
              _welcomeMessage('Welcome!'),
              _textLabel('Set Currency'),
              dropDownDesign(_currencyItems, currencyValue, (value) {
                FocusScope.of(context).requestFocus(new FocusNode());
                setState(() {
                  currencyValue = value;
                });
              }),
              buttonOk(),
            ],
          ),
        ),
      ),
    );
  }

  //label
  Widget _textLabel(String label) {
    return Container(
      margin: EdgeInsets.only(left: 40),
      child: Align(
          alignment: Alignment.centerLeft,
          child: new Text(label, style: TextStyle(color: Colors.grey))),
    );
  }

  //Welcome Message
  Widget _welcomeMessage(String text) {
    return Container(
      margin: EdgeInsets.all(60),
      child: Text(
        text,
        style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget dropDownDesign(
      List<DropdownMenuItem<String>> items, String value, Function onChanged) {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 5, 40, 80),
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

  Widget buttonOk() {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
      child: ButtonTheme(
        minWidth: double.infinity,
        height: 50,
        child: RaisedButton(
          onPressed: () {
            // showDialog();
          },
          color: Colors.purple[800],
          textColor: Colors.white,
          child: Text('Ok'),
        ),
      ),
    );
  }
}
