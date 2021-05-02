import 'package:flutter/material.dart';

import '../routes.dart';
import '../routes.dart';
import '../routes.dart';

class TransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text('Transactions Screen'),
          //  RaisedButton(onPressed: () {Routes.pushNamed(Routes.SCREEN_ADD_TRANSACTION, navigator: Routes.transactionNavigator)})
        ],
      ),
    );
  }

  Widget _buildAction(int index) {
    return index == 0
        ? Padding(
            padding: const EdgeInsets.only(right: 17),
            child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.purple[100],
                  size: 38,
                ),
                onPressed: () {
                  Routes.pushNamed(Routes.SCREEN_ADD_BUDGET,
                      navigator: Routes.homeNavigator);
                }),
          )
        : const Padding(
            padding: EdgeInsets.only(right: 17),
            child: Icon(
              Icons.double_arrow_rounded,
              color: Colors.black,
              size: 38,
            ),
          );
  }

  // Routes.pushNamed(Routes.SCREEN_ADD_BUDGET,
  //                     navigator: Routes.homeNavigator);
}
