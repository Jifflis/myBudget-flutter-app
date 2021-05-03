import 'package:flutter/material.dart';
import 'package:mybudget/model/account.dart';

class ViewBudgetScreen extends StatelessWidget {
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController budgetAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // catch args from route pushNamed
    //
    //
    final Account budget = ModalRoute.of(context).settings.arguments as Account;
    accountNameController.text = budget.title;
    budgetAmountController.text = budget.budget.toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.pop(context)),
        backgroundColor: Colors.purple[800],
        elevation: 0,
        centerTitle: true,
        title: const Text('Budget Account'),
      ),
      body: Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _textButton(label: 'Edit', function: () {}),
                      const SizedBox(width: 10),
                      _textButton(label: 'Delete', function: () {}),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _fieldLabel('Account name'),
                  const SizedBox(height: 15),
                  _textField('Enter account name',
                      controller: accountNameController),
                  const SizedBox(height: 30),
                  _fieldLabel('Budget amount'),
                  const SizedBox(height: 15),
                  _textField('Enter budget amount',
                      controller: budgetAmountController),
                  const SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      _fieldLabel('Auto deduct'),
                      Checkbox(value: false, onChanged: (bool value) {}),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _button(label: 'Add Transaction', function: () {}),
                  const SizedBox(height: 30),
                  _button(label: 'View Transaction', function: () {}),
                ],
              ),
            )),
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
  Widget _textField(String hintText,
      {@required TextEditingController controller}) {
    return Container(
      child: TextField(
        controller: controller,
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

  /// BUTTON
  ///
  ///
  Widget _button({@required String label, @required Function function}) {
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.purple[800]),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
          onPressed: function),
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
