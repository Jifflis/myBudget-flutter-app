import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybudget/view/widget/budget_button.dart';

class ConfirmationWidget extends StatelessWidget {
  const ConfirmationWidget({
    Key key,
    @required this.yes,
    @required this.cancel,
    @required this.message,
  }) : super(key: key);
  final Function yes;
  final Function cancel;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 40),
      margin: const EdgeInsets.symmetric(vertical: 17, horizontal: 17),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 20),
          Icon(
            CupertinoIcons.question_circle_fill,
            color: Colors.purple[800],
            size: 80,
          ),
          const SizedBox(height: 5),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 25),
          ),
          const SizedBox(height: 30),
          BudgetButton(yes, 'Yes'),
          const SizedBox(height: 10),
          BudgetButton(cancel, 'Cancel'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
