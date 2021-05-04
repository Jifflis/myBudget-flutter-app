import 'package:flutter/material.dart';
import 'package:mybudget/view/screen/template_screen.dart';
import 'package:mybudget/view/widget/budget_field_label.dart';
import 'package:mybudget/view/widget/budget_text_field.dart';

import '../widget/budget_button.dart';

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
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0.0, 40, 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 58),
            const BudgetFieldLabel(label: 'Account name'),
            const SizedBox(height: 15),
            const BudgetTextField(hintText: 'Enter account name'),
            const SizedBox(height: 30),
            const BudgetFieldLabel(label: 'Budget amount'),
            const SizedBox(height: 15),
            const BudgetTextField(hintText: 'Enter budget amount'),
            const SizedBox(height: 30),
            Row(
              children: <Widget>[
                const BudgetFieldLabel(label: 'Auto deduct'),
                Checkbox(value: false, onChanged: (bool value) {}),
              ],
            ),
            const SizedBox(height: 30),
            BudgetButton(() {}, 'Save'),
          ],
        ),
      ),
    );
  }
}
