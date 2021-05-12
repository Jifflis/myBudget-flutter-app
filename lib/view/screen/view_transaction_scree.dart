import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybudget/controller/add_transaction_controller.dart';
import 'package:mybudget/controller/view_transaction_controller.dart';
import 'package:mybudget/view/widget/add_transaction_dropdown.dart';
import 'package:mybudget/view/widget/transaction_field_label.dart';
import 'package:mybudget/view/widget/transaction_text_field.dart';

import '../../model/account.dart';
import 'template_screen.dart';

class ViewTransactionScreen extends TemplateScreen {
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController budgetAmountController = TextEditingController();
  final TextEditingController transactionDateController =
      TextEditingController();
  final TextEditingController transactionRemarksController =
      TextEditingController();

  @override
  Widget getLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () => Navigator.pop(context));

  @override
  String get title => 'View Transaction';

  @override
  Widget buildBody(BuildContext context) {
    // catch args from route pushNamed
    //
    //
    final Account transaction =
        ModalRoute.of(context).settings.arguments as Account;
    accountNameController.text = transaction.title;
    budgetAmountController.text = transaction.budget.toStringAsFixed(2);
    transactionDateController.text = 'May 04, 2020';
    transactionRemarksController.text = 'Utang';

    final ViewTransactionController _viewTranController =
        Get.put(ViewTransactionController());

    final AddTransactionController _addTranController =
        Get.put(AddTransactionController());

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.purple[800],
        child: Container(
            padding: const EdgeInsets.fromLTRB(40, 0.0, 40, 10),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: SingleChildScrollView(
                child: GetBuilder<ViewTransactionController>(
              init: _viewTranController,
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        _textButton(
                            label: _viewTranController.isEnabled
                                ? 'Update'
                                : 'Edit',
                            function: () {
                              _viewTranController.isEnabled =
                                  !_viewTranController.isEnabled;
                            }),
                        const SizedBox(width: 10),
                        _textButton(label: 'Delete', function: () {}),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const TransactionFieldLabel(label: 'Account name'),
                    const SizedBox(height: 15),
                    if (!_viewTranController.isEnabled)
                      TransactionTextField(
                          isEnabled: _viewTranController.isEnabled,
                          hintText: 'Enter account name',
                          controller: accountNameController),
                    if (_viewTranController.isEnabled)
                      AddTransactionDropdown((Account value) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        _addTranController.selectedCurrency = value;
                      }),
                    const SizedBox(height: 30),
                    const TransactionFieldLabel(label: 'Transaction Date'),
                    const SizedBox(height: 15),
                    TransactionTextField(
                        isEnabled: _viewTranController.isEnabled,
                        hintText: 'Enter Transaction Date',
                        controller: transactionDateController),
                    const SizedBox(height: 15),
                    const TransactionFieldLabel(label: 'Transaction amount'),
                    const SizedBox(height: 15),
                    TransactionTextField(
                        isEnabled: _viewTranController.isEnabled,
                        hintText: 'Enter Transaction amount',
                        controller: budgetAmountController),
                    const SizedBox(height: 15),
                    const TransactionFieldLabel(label: 'Remarks'),
                    const SizedBox(height: 15),
                    TransactionTextField(
                        isEnabled: _viewTranController.isEnabled,
                        hintText: 'Apartment Payment',
                        controller: transactionRemarksController),
                  ],
                );
              },
            ))),
      ),
    );
  }

  /// TEXT BUTTON
  ///
  ///
  Widget _textButton({@required String label, @required Function function}) {
    return InkWell(
      onTap: function,
      child: Text(
        label,
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }
}
