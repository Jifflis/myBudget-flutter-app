import 'package:flutter/material.dart';

class BudgetButton extends StatelessWidget {
  const BudgetButton(
    this.onPressed,
    this.text,
  );

  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              onPressed != null ? Colors.purple[800] : Colors.grey),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
