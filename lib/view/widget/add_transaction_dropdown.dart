import 'package:flutter/material.dart';
import 'package:mybudget/controller/add_transaction_controller.dart';
import 'package:get/get.dart';

import '../../model/account.dart';

class AddTransactionDropdown extends StatelessWidget {
  const AddTransactionDropdown(
    this.onChange,
  );

  final Function onChange;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: Colors.purple,
              width: 2,
            )),
        child: GetBuilder<AddTransactionController>(
          builder: (AddTransactionController controller) => Container(
            // margin: EdgeInsets.all(40),
            padding: const EdgeInsets.only(left: 15, right: 15),
            width: double.infinity,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Account>(
                value: controller.selectedAccount,
                onChanged: onChange,
                items: controller.accountList
                    .map(
                      (Account currency) => DropdownMenuItem<Account>(
                        value: currency,
                        child: Text(
                          currency.title,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ));
  }
}
