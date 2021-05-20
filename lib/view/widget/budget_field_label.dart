import 'package:flutter/material.dart';

class BudgetFieldLabel extends StatelessWidget {
  const BudgetFieldLabel({Key key, @required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
