import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:mybudget/controller/view_budget_controller.dart';
import 'package:mybudget/model/account.dart';
import 'package:mybudget/view/screen/template_screen.dart';
import 'package:mybudget/view/widget/budget_button.dart';
import 'package:mybudget/view/widget/budget_field_label.dart';
import 'package:mybudget/view/widget/budget_text_field.dart';

class ViewBudgetScreen extends TemplateScreen {
  @override
  Widget getLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
        final ViewBudgetController controller = Get.find();
        controller.resetPage();
        Navigator.pop(context);
      });

  @override
  String get title => 'Budget Account';

  @override
  Widget buildBody(BuildContext context) {
    // catch args from route pushNamed
    //
    //
    final Account account =
        ModalRoute.of(context).settings.arguments as Account;

    final ViewBudgetController controller = Get.put(ViewBudgetController());
    controller.getParams(account);

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.purple[800],
        child: Container(
            padding: const EdgeInsets.fromLTRB(40, 0.0, 40, 10),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: SingleChildScrollView(
                child: GetBuilder<ViewBudgetController>(
              init: controller,
              builder: (_) {
                return Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          _textButton(
                              label: controller.isEnabled ? 'Cancel' : 'Edit',
                              function: () {
                                FocusScope.of(context).unfocus();
                                controller.edit();
                              }),
                          const SizedBox(width: 10),
                          _textButton(
                              label: 'Delete',
                              function: () {
                                controller.deleteAccount();
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const BudgetFieldLabel(label: 'Account name'),
                      const SizedBox(height: 15),
                      BudgetTextField(
                          isEnabled: controller.isEnabled,
                          hintText: 'Enter account name',
                          validator: controller.textFieldValidator,
                          controller: controller.accountNameController),
                      const SizedBox(height: 30),
                      const BudgetFieldLabel(label: 'Budget amount'),
                      const SizedBox(height: 15),
                      BudgetTextField(
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          textInputFormatterList: <FilteringTextInputFormatter>[
                            if (!controller.isEnabled)
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          isEnabled: controller.isEnabled,
                          hintText: 'Enter budget amount',
                          validator: controller.textFieldValidator,
                          controller: controller.formattedBudgetAmount()),
                      const SizedBox(height: 30),
                      Row(
                        children: <Widget>[
                          const BudgetFieldLabel(label: 'Auto deduct'),
                          Checkbox(
                              value: controller.isAutoDeduct,
                              onChanged: (bool value) =>
                                  controller.isAutoDeduct = value),
                        ],
                      ),
                      const SizedBox(height: 30),
                      BudgetButton(
                          controller.isEnabled
                              ? controller.updateAccount
                              : null,
                          'Update'),
                    ],
                  ),
                );
              },
            ))),
      ),
    );
  }

  /// TEXT BUTTON
  ///
  ///
  Widget _textButton({@required String label, @required Function function}) {
    return InkWell(
      onTap: function,
      child: Text(
        label,
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }
}
