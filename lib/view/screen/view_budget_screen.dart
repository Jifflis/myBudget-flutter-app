import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:mybudget/controller/view_budget_controller.dart';
import 'package:mybudget/model/account.dart';
import 'package:mybudget/view/screen/template_screen.dart';
import 'package:mybudget/view/widget/budget_button.dart';
import 'package:mybudget/view/widget/budget_field_label.dart';
import 'package:mybudget/view/widget/budget_text_field.dart';

class ViewBudgetScreen extends TemplateScreen {
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController budgetAmountController = TextEditingController();

  @override
  Widget getLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () => Navigator.pop(context));

  @override
  String get title => 'Budget Account';

  @override
  Widget buildBody(BuildContext context) {
    // catch args from route pushNamed
    //
    //
    final Account budget = ModalRoute.of(context).settings.arguments as Account;
    accountNameController.text = budget.title;
    budgetAmountController.text = budget.budget.toStringAsFixed(2);

    final ViewBudgetController _controller = Get.put(ViewBudgetController());

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
              init: _controller,
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        _textButton(
                            label: _controller.isEnabled ? 'Update' : 'Edit',
                            function: () {
                              _controller.isEnabled = !_controller.isEnabled;
                            }),
                        const SizedBox(width: 10),
                        _textButton(label: 'Delete', function: () {}),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const BudgetFieldLabel(label: 'Account name'),
                    const SizedBox(height: 15),
                    BudgetTextField(
                        isEnabled: _controller.isEnabled,
                        hintText: 'Enter account name',
                        controller: accountNameController),
                    const SizedBox(height: 30),
                    const BudgetFieldLabel(label: 'Budget amount'),
                    const SizedBox(height: 15),
                    BudgetTextField(
                        isEnabled: _controller.isEnabled,
                        hintText: 'Enter budget amount',
                        controller: budgetAmountController),
                    const SizedBox(height: 30),
                    Row(
                      children: <Widget>[
                        const BudgetFieldLabel(label: 'Auto deduct'),
                        Checkbox(value: false, onChanged: (bool value) {}),
                      ],
                    ),
                    const SizedBox(height: 30),
                    BudgetButton(() {}, 'Add Transaction'),
                    const SizedBox(height: 30),
                    BudgetButton(() {}, 'View Transaction'),
                  ],
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
