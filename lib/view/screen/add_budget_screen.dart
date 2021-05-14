import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controller/add_budget_controller.dart';
import '../widget/budget_button.dart';
import '../widget/budget_field_label.dart';
import '../widget/budget_text_field.dart';
import 'template_screen.dart';

class AddBudgetScreen extends TemplateScreen {
  @override
  Widget getLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () => Navigator.pop(context),
      );

  @override
  String get title => 'Add Budget Account';

  @override
  Widget buildBody(BuildContext context) {
    final AddBudgetController controller = Get.put(AddBudgetController());
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0.0, 40, 10),
      child: SingleChildScrollView(
        child: GetBuilder<AddBudgetController>(
            init: controller,
            builder: (_) {
              return Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 58),
                    const BudgetFieldLabel(label: 'Account name'),
                    const SizedBox(height: 15),
                    BudgetTextField(
                      controller: controller.accountController,
                      hintText: 'Enter account name',
                      validator: controller.textFieldValidator,
                    ),
                    const SizedBox(height: 30),
                    const BudgetFieldLabel(label: 'Budget amount'),
                    const SizedBox(height: 15),
                    BudgetTextField(
                      controller: controller.amountController,
                      hintText: 'Enter budget amount',
                      keyboardType: TextInputType.number,
                      validator: controller.textFieldValidator,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: <Widget>[
                        const BudgetFieldLabel(label: 'Auto deduct'),
                        Checkbox(
                            value: controller.isAutoDeduct,
                            onChanged: (bool value) {
                              controller.isAutoDeduct = value;
                            }),
                      ],
                    ),
                    const SizedBox(height: 30),
                    BudgetButton(() {
                      FocusScope.of(context).unfocus();
                      controller.save();
                    }, 'Save'),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
