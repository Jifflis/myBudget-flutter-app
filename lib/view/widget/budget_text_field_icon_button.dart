import 'package:flutter/material.dart';

class BudgetTextFieldIconButton extends StatelessWidget {
  const BudgetTextFieldIconButton(
      {Key key,
      this.hintText,
      this.controller,
      this.validator,
      this.isEnabled,
      @required this.onPressed,
      @required this.iconData})
      : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final Function(String) validator;
  final bool isEnabled;
  final Function onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        enabled: isEnabled ?? true,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: const TextStyle(fontStyle: FontStyle.italic),
            suffixIcon: IconButton(
              onPressed: onPressed,
              icon: Icon(
                iconData,
                color: Colors.purple[800],
                size: 35,
              ),
            ),
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
