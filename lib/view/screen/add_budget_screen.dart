import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybudget/view/dialog/add_account_success_dialog.dart';

import '../../controller/add_budget_controller.dart';
import '../widget/budget_button.dart';
import '../widget/budget_field_label.dart';
import '../widget/budget_text_field.dart';
import 'template_screen.dart';

class AddBudgetScreen extends TemplateScreen {
  @override
  Widget getLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          final AddBudgetController controller = Get.find();
          controller.resetFields();
          Navigator.pop(context);
        },
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
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textInputFormatterList: <FilteringTextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      controller: controller.amountController,
                      hintText: 'Enter budget amount',
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
                    BudgetButton(() async {
                      FocusScope.of(context).unfocus();
                      if (await controller.save()) {
                        showAddAccountSuccessDialog(
                            context: context,
                            close: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            addAnother: () {
                              Navigator.pop(context);
                            },
                            message: 'Account has been saved!');
                        controller.resetFields();
                      }
                    }, 'Save'),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
