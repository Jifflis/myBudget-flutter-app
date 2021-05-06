import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:mybudget/controller/change_currency_controller.dart';
import 'package:mybudget/model/currency.dart';
import 'package:mybudget/view/screen/template_screen.dart';
import 'package:mybudget/view/widget/budget_button.dart';
import 'package:mybudget/view/widget/budget_field_label.dart';

class ChangeCurrencyScreen extends TemplateScreen {
  @override
  String get title => 'Change Currency';

  @override
  Widget getLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () => Navigator.pop(context),
      );

  @override
  Widget buildBody(BuildContext context) {
    final ChangeCurrencyController _controller =
        Get.put(ChangeCurrencyController());
    return Container(
      margin: const EdgeInsets.fromLTRB(40, 5, 40, 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const BudgetFieldLabel(label: 'Set currency'),
          _buildDropDown((Currency value) {
            FocusScope.of(context).requestFocus(FocusNode());
            _controller.selectedCurrency = value;
          }),
          BudgetButton(() {}, 'Ok'),
        ],
      ),
    );
  }

  /// Build dropdown widget
  ///
  ///
  Widget _buildDropDown(Function onChanged) {
    return GetBuilder<ChangeCurrencyController>(
      builder: (ChangeCurrencyController controller) => Container(
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
