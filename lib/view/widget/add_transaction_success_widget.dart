import 'package:flutter/material.dart';
import 'package:mybudget/view/widget/budget_button.dart';

class AddTransactionSuccessWidget extends StatelessWidget {
  const AddTransactionSuccessWidget({
    Key key,
    @required this.close,
    @required this.addAnother,
    @required this.title,
    @required this.amount,
    @required this.remarks,
  }) : super(key: key);
  final Function close;
  final Function addAnother;
  final String title;
  final String amount;
  final String remarks;

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
            Icons.check_circle_outline,
            color: Colors.purple[800],
            size: 80,
          ),
          const SizedBox(height: 5),
          const Text(
            'Success!',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 40),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Amount: $amount',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Remarks: $remarks',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 30),
          BudgetButton(close, 'Close'),
          const SizedBox(height: 10),
          BudgetButton(addAnother, 'Add another'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
