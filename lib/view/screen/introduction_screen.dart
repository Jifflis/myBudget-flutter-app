import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybudget/controller/introduction_controller.dart';
import 'package:mybudget/model/currency.dart';
import 'package:mybudget/view/screen/template_screen.dart';
import 'package:mybudget/view/widget/budget_button.dart';

class IntroductionScreen extends TemplateScreen {
  @override
  String get title => 'myBudget';

  @override
  Widget buildBody(BuildContext context) {
    final IntroductionController controller = Get.put(IntroductionController());

    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.purple[800],
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 8),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: Container(
            margin: const EdgeInsets.fromLTRB(40, 5, 40, 80),
            child: Column(
              children: <Widget>[
                _buildWelcomeMessage(),
                _buildLabel(),
                _buildDropDown((Currency value) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  controller.selectedCurrency = value;
                }),
                BudgetButton(() {}, 'Ok'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return Container(
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Set Currency',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  ///Welcome Message
  ///
  ///
  Widget _buildWelcomeMessage() {
    return Container(
      margin: const EdgeInsets.only(top: 36,bottom: 52),
      child: const Text(
        'Welcome!',
        style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Build dropdown widget
  ///
  ///
  Widget _buildDropDown(Function onChanged) {
    return GetBuilder<IntroductionController>(
      builder: (IntroductionController controller) => Container(
        margin: const EdgeInsets.only(bottom: 70,top: 20),
        decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[300].withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ]),
        // margin: EdgeInsets.all(40),
        padding: const EdgeInsets.only(left: 15, right: 15),
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
}
