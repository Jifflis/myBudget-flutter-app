import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybudget/controller/account_controller.dart';

import '../model/account.dart';

class Add_Transaction_Screen extends StatelessWidget {
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
        title: const Text('Add Transaction'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final AccountController controller = Get.put(AccountController());

    return Container(
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
              _fieldLabel('Budget Account'),
              _buildDropDown((Account value) {
                FocusScope.of(context).requestFocus(FocusNode());
                controller.selectedCurrency = value;
              }),
              const SizedBox(height: 25),
              _fieldLabel('Account name'),
              _textField('Amount'),
              const SizedBox(height: 15),
              _fieldLabel('Add Remarks'),
              _textField('Add Remarks'),
              const SizedBox(height: 30),
              _submit(),
            ],
          ),
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
      style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
    );
  }

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
          ),
        ),
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3,
            offset: Offset(0, 2),
          )
        ],
      ),
    );
  }

  Widget _buildDropDown(Function onChanged) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: Colors.purple,
              width: 2,
            )),
        child: GetBuilder<AccountController>(
          builder: (AccountController controller) => Container(
            // margin: EdgeInsets.all(40),
            padding: const EdgeInsets.only(left: 15, right: 15),
            width: double.infinity,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Account>(
                value: controller.selectedAccount,
                onChanged: onChanged,
                items: controller.accountList
                    .map(
                      (Account currency) => DropdownMenuItem<Account>(
                        value: currency,
                        child: Text(
                          currency.title,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ));
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
