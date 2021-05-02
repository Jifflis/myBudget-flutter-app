import 'package:flutter/material.dart';

class ViewTransactionScreen extends StatelessWidget {
  @override
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
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _flatButton('Edit'),
                  const SizedBox(
                    width: 5,
                  ),
                  _flatButton('Delete'),
                ],
              ),
              const SizedBox(height: 58),
              _fieldLabel('Account name'),
              _textField('Account name', 'Apartment Rental'),
              const SizedBox(height: 15),
              _fieldLabel('Transaction Date'),
              _textField('Date', 'May 2, 2021'),
              const SizedBox(height: 15),
              _fieldLabel('Transaction amount'),
              _textField('amount', '20,000'),
              const SizedBox(
                height: 15,
              ),
              _fieldLabel('Add Remarks'),
              _textField('Add Remarks', 'rental'),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  //Flatbutton
  Widget _flatButton(String label) {
    return InkWell(
        onTap: () {},
        child: Text(label,
            style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic)));
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

  Widget _textField(String hintText, String initialValue) {
    return Container(
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: const TextStyle(fontStyle: FontStyle.italic),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
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
}
