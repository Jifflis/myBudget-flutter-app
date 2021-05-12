import 'package:flutter/material.dart';
import 'package:mybudget/controller/add_transaction_controller.dart';
import 'package:mybudget/view/widget/add_transaction_dropdown.dart';
import 'package:get/get.dart';

import '../../model/account.dart';
import '../widget/budget_button.dart';
import '../widget/budget_field_label.dart';
import '../widget/budget_text_field.dart';
import 'template_screen.dart';

class AddTransactionScreen extends TemplateScreen {
  @override
  Widget getLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () => Navigator.pop(context),
      );

  @override
  String get title => 'Add Transaction';

  @override
  Widget buildBody(BuildContext context) {
    final AddTransactionController controller =
        Get.put(AddTransactionController());
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0.0, 40, 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 58),
            const BudgetFieldLabel(label: 'Budget Account'),
            const SizedBox(height: 15),
            AddTransactionDropdown((Account value) {
              FocusScope.of(context).requestFocus(FocusNode());
              controller.selectedCurrency = value;
            }),
            const SizedBox(height: 15),
            const BudgetFieldLabel(label: 'Amount'),
            const SizedBox(height: 15),
            const BudgetTextField(hintText: 'Enter Amount'),
            const SizedBox(height: 30),
            const BudgetFieldLabel(label: 'Add Remarks'),
            const SizedBox(height: 15),
            const BudgetTextField(hintText: 'Enter Add Remarks'),
            const SizedBox(height: 30),
            const SizedBox(height: 30),
            BudgetButton(() {}, 'Save'),
          ],
        ),
      ),
    );
  }
}
