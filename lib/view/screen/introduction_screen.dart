import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/introduction_controller.dart';
import '../../enum/status.dart';
import '../../model/currency.dart';
import '../../routes.dart';
import '../widget/budget_button.dart';
import 'template_screen.dart';

class IntroductionScreen extends TemplateScreen {
  @override
  Widget get title => const Text('My Budget');

  @override
  Widget buildBody(BuildContext context) {
    final IntroductionController controller = Get.put(IntroductionController());
    return Container(
      margin: const EdgeInsets.fromLTRB(40, 5, 40, 80),
      child: Column(
        children: <Widget>[
          _buildWelcomeMessage(),
          _buildLabel(),
          _buildDropDown((Currency value) {
            FocusScope.of(context).requestFocus(FocusNode());
            controller.selectedCurrency = value;
          }),
          _buildButton(),
        ],
      ),
    );
  }

  ///Build ok button
  ///
  ///
  Widget _buildButton() => GetBuilder<IntroductionController>(
        builder: (IntroductionController controller) => BudgetButton(
            controller.status == Status.LOADING
                ? null
                : () {
                    controller.save().then((Status status) {
                      if (status == Status.COMPLETED) {
                        Routes.pushReplacementNamed(Routes.SCREEN_MAIN);
                      }
                    });
                  },
            'Ok'),
      );

  ///Build label
  ///
  ///
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
      margin: const EdgeInsets.only(top: 36, bottom: 52),
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
        margin: const EdgeInsets.only(bottom: 70, top: 20),
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
                    child: Text(currency.name),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
