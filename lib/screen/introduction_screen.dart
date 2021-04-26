import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybudget/controller/introduction_controller.dart';
import 'package:mybudget/model/currency.dart';

class IntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          _getLeadingIcon(),
          _getTitle(),
        ),
        body: _buildBody(context));
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

  Widget _buildBody(BuildContext context) {
    IntroductionController controller = Get.put(IntroductionController());

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
              _buildWelcomeMessage(),
              _buildLabel(),
              _buildDropDown((Currency value) {
                FocusScope.of(context).requestFocus(new FocusNode());
                controller.selectedCurrency = value;
              }),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return Container(
      margin: EdgeInsets.only(left: 40),
      child: Align(
        alignment: Alignment.centerLeft,
        child: new Text(
          'Set Currency',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  //Welcome Message
  Widget _buildWelcomeMessage() {
    return Container(
      margin: EdgeInsets.all(60),
      child: Text(
        'Welcome!',
        style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDropDown(Function onChanged) {
    return GetBuilder<IntroductionController>(
      builder: (IntroductionController controller) => Container(
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
          child: DropdownButton<Currency>(
            value: controller.selectedCurrency,
            onChanged: onChanged,
            items: controller.currencyList
                .map(
                  (Currency currency) => DropdownMenuItem<Currency>(
                    value: currency,
                    child: Text(currency.currency),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
      child: ButtonTheme(
        minWidth: double.infinity,
        height: 50,
        child: TextButton(
          onPressed: () {
            // showDialog();
          },
          child: Text('Ok',style: TextStyle(color: Colors.white),),
          style: TextButton.styleFrom(
          backgroundColor: Colors.purple[800],
            minimumSize: Size(200,45)
        ),
        ),
      ),
    );
  }
}
