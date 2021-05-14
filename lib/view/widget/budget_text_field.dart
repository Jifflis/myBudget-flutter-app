import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BudgetTextField extends StatelessWidget {
  const BudgetTextField({
    Key key,
    this.hintText,
    this.controller,
    this.validator,
    this.isEnabled,
    this.textInputFormatterList,
    this.keyboardType,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final Function(String) validator;
  final bool isEnabled;
  final List<TextInputFormatter> textInputFormatterList;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 50,
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                )
              ]),
        ),
        Container(
          child: TextFormField(
            keyboardType: keyboardType,
            inputFormatters: textInputFormatterList,
            enabled: isEnabled ?? true,
            validator: validator,
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
        ),
      ],
    );
  }
}
