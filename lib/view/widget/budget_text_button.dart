import 'package:flutter/material.dart';

class BudgetTextButton extends StatelessWidget {
  const BudgetTextButton({
    Key key,
    @required this.label,
    @required this.onPressed,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  final String label;
  final Function onPressed;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black87,
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.bold,
        ),
      ),
    );
  }
}
