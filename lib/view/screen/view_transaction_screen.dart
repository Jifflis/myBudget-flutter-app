import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybudget/view/dialog/confirmation_dialog.dart';
import 'package:oktoast/oktoast.dart';

import '../../controller/view_transaction_controller.dart';
import '../../model/transaction.dart';
import '../../repository/acount_repository.dart';
import '../../repository/transaction_repository.dart';
import '../widget/budget_button.dart';
import '../widget/budget_text_button.dart';
import '../widget/budget_text_field.dart';
import '../widget/transaction_field_label.dart';
import 'template_screen.dart';

class ViewTransactionScreen extends TemplateScreen {
  @override
  Widget getLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
        final ViewTransactionController controller = Get.find();
        controller.resetFields();
        Navigator.pop(context);
      });

  @override
  String get title => 'View Transaction';

  @override
  Widget buildBody(BuildContext context) {
    // catch args from route pushNamed
    //
    //
    final Transaction transaction =
        ModalRoute.of(context).settings.arguments as Transaction;

    final ViewTransactionController controller =
        Get.put(ViewTransactionController(
      transactionRepository: TransactionRepository(),
      accountRepository: AccountRepository(),
    ));

    controller.getParams(transaction);

    return SingleChildScrollView(
      child: Container(
        color: Colors.purple[800],
        child: Container(
          padding: const EdgeInsets.fromLTRB(40, 0.0, 40, 10),
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
              init: controller,
              builder: (_) {
                return Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          BudgetTextButton(
                              label: controller.isEnabled ? 'Cancel' : 'Edit',
                              onPressed: () =>
                                  controller.isEnabled = !controller.isEnabled),
                          const SizedBox(width: 10),
                          BudgetTextButton(
                              label: 'Delete',
                              onPressed: () {
                                const String message =
                                    'Are you sure you want to delete?';
                                showConfirmationDialog(
                                    context: context,
                                    message: message,
                                    yes: () {
                                      controller.deleteTransaction();
                                      controller.resetFields();
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    cancel: () => Navigator.pop(context));
                              }),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const TransactionFieldLabel(label: 'Account name'),
                      const SizedBox(height: 15),
                      BudgetTextField(
                          isEnabled: false,
                          hintText: 'Enter account name',
                          controller: controller.titleController),
                      const SizedBox(height: 30),
                      const TransactionFieldLabel(label: 'Transaction Date'),
                      const SizedBox(height: 15),
                      BudgetTextField(
                          isEnabled: false,
                          hintText: 'Enter Transaction Date',
                          controller: controller.dateController),
                      const SizedBox(height: 15),
                      const TransactionFieldLabel(label: 'Transaction amount'),
                      const SizedBox(height: 15),
                      BudgetTextField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        textInputFormatterList: <FilteringTextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          ),
                        ],
                        isEnabled: controller.isEnabled,
                        hintText: 'Enter Transaction amount',
                        controller: controller.amountController,
                        validator: controller.textFieldValidator,
                      ),
                      const SizedBox(height: 15),
                      const TransactionFieldLabel(label: 'Remarks'),
                      const SizedBox(height: 15),
                      BudgetTextField(
                        isEnabled: controller.isEnabled,
                        hintText: 'Remarks',
                        controller: controller.remarksController,
                        validator: controller.textFieldValidator,
                      ),
                      const SizedBox(height: 30),
                      BudgetButton(
                          controller.isEnabled
                              ? () async {
                                  await controller.updateTransaction()
                                      ? showToast('Update Success',
                                          position: ToastPosition.bottom)
                                      : showToast('Update Failed',
                                          position: ToastPosition.bottom);
                                }
                              : null,
                          'Update'),
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
