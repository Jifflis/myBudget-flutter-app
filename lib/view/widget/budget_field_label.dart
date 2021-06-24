import 'package:flutter/material.dart';

class BudgetFieldLabel extends StatelessWidget {
  const BudgetFieldLabel({
    Key key,
    @required this.label,
    this.fontSize = 16,
  }) : super(key: key);

  final String label;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.black87,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
