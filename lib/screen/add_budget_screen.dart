import 'package:flutter/material.dart';

class AddBudgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.pop(context)),
        backgroundColor: Colors.purple[800],
        elevation: 0,
        centerTitle: true,
        title: const Text('Add Budget Account'),
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
                  _submit(),
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

  Widget _submit() {
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
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {}),
    );
  }
}
