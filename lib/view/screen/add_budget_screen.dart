import 'package:flutter/material.dart';
import 'package:mybudget/view/screen/template_screen.dart';

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
            _fieldLabel('Account name'),
            const SizedBox(height: 15),
            _textField('Enter account name'),
            const SizedBox(height: 30),
            _fieldLabel('Budget amount'),
            const SizedBox(height: 15),
            _textField('Enter budget amount'),
            const SizedBox(height: 30),
            Row(
              children: <Widget>[
                _fieldLabel('Auto deduct'),
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


  /// LABEL
  ///
  ///
  Widget _fieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// TEXT FIELD
  ///
  ///
  Widget _textField(String hintText) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: const TextStyle(fontStyle: FontStyle.italic),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            )),
      ),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
              offset: Offset(0, 2),
            )
          ]),
    );
  }
}
