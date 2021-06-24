import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybudget/constant/general.dart';
import 'package:oktoast/oktoast.dart';

import '../../controller/view_transaction_controller.dart';
import '../../enum/transaction_type.dart';
import '../../model/transaction.dart';
import '../../repository/acount_repository.dart';
import '../../repository/transaction_repository.dart';
import '../../routes.dart';
import '../dialog/confirmation_dialog.dart';
import '../dialog/success_dialog.dart';
import '../widget/budget_button.dart';
import '../widget/budget_date_selector_button.dart';
import '../widget/budget_field_label.dart';
import '../widget/budget_text_button.dart';
import '../widget/budget_text_field.dart';
import '../widget/radio_label.dart';
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
  Widget get title => const Text('View Transaction');

  @override
  Widget buildBody(BuildContext context) {
    final Transaction transaction =
        ModalRoute.of(context).settings.arguments as Transaction;

    final ViewTransactionController controller =
        Get.put(ViewTransactionController(
      transactionRepository: TransactionRepository(),
      accountRepository: AccountRepository(),
    ));

    controller.getParams(transaction);

    return _buildContent(controller, context);
  }

  /// Build content
  ///
  Widget _buildContent(
      ViewTransactionController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0.0, 40, 10),
      child: SingleChildScrollView(
        child: GetBuilder<ViewTransactionController>(
          init: controller,
          builder: (_) {
            return _buildForm(controller, context);
          },
        ),
      ),
    );
  }

  /// Build form
  ///
  Widget _buildForm(
      ViewTransactionController controller, BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 28),
          _buildMenuButton(controller, context),
          const SizedBox(height: 24),
          const BudgetFieldLabel(label: 'Transaction Type', fontSize: 18),
          _buildSwitcherMenu(),
          const SizedBox(height: 15),
          const BudgetFieldLabel(label: 'Account name'),
          const SizedBox(height: 15),
          _buildAccountNameField(controller),
          const SizedBox(height: 30),
          const BudgetFieldLabel(label: 'Transaction Date'),
          const SizedBox(height: 15),
          _buildDateField(controller),
          const SizedBox(height: 15),
          const BudgetFieldLabel(label: 'Transaction amount'),
          const SizedBox(height: 15),
          _buildAmountField(controller),
          const SizedBox(height: 15),
          const BudgetFieldLabel(label: 'Remarks'),
          const SizedBox(height: 15),
          _buildRemarkField(controller),
          const SizedBox(height: 30),
          _buildButton(controller, context),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  /// Build transaction type section
  ///
  Widget _buildSwitcherMenu() => GetBuilder<ViewTransactionController>(
        builder: (ViewTransactionController controller) => Container(
          margin: const EdgeInsets.only(right: 12),
          child: Row(
            children: <Widget>[
              RadioLabel<TransactionType>(
                label: 'Expense',
                alignTop: 2,
                value: TransactionType.expense,
                groupValue: controller.transactionType,
                onChange: (TransactionType value) {
                  controller.transactionType = TransactionType.expense;
                },
              ),
              const SizedBox(
                width: 12,
              ),
              RadioLabel<TransactionType>(
                label: 'Income',
                alignTop: 2,
                value: TransactionType.income,
                groupValue: controller.transactionType,
                onChange: (TransactionType value) {
                  controller.transactionType = TransactionType.income;
                },
              ),
            ],
          ),
        ),
      );

  /// Build button
  ///
  Widget _buildButton(
      ViewTransactionController controller, BuildContext context) {
    return BudgetButton(
        controller.isEnabled
            ? () async {
                if (!controller.formKey.currentState.validate()) {
                  return false;
                }

                if (controller.remarksController.text == SYSTEM_GEN) {
                  showToast('Invalid remarks!');
                  return false;
                }

                if (await controller.updateTransaction()) {
                  const String message = 'Transaction has been updated!';
                  showSuccessDialog(
                      context: context,
                      close: () {
                        Navigator.pop(context);
                        Routes.pop(navigator: Routes.transactionNavigator);
                      },
                      message: message);
                  controller.resetFields();
                }
              }
            : null,
        'Update');
  }

  /// Build remark field
  BudgetTextField _buildRemarkField(ViewTransactionController controller) {
    return BudgetTextField(
      isEnabled: controller.isEnabled,
      hintText: 'e.g. Electric bill payment',
      controller: controller.remarksController,
      validator: controller.textFieldValidator,
    );
  }

  /// Build amount field
  ///
  BudgetTextField _buildAmountField(ViewTransactionController controller) {
    return BudgetTextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputFormatterList: <FilteringTextInputFormatter>[
        if (controller.isEnabled)
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,2}'),
          ),
      ],
      isEnabled: controller.isEnabled,
      hintText: 'e.g. 500',
      controller: controller.formattedAmount(),
      validator: controller.textFieldValidator,
    );
  }

  /// Build account field
  ///
  BudgetTextField _buildAccountNameField(ViewTransactionController controller) {
    return BudgetTextField(
        isEnabled: false,
        hintText: 'Enter account name',
        controller: controller.titleController);
  }

  /// Build menu button
  ///
  Row _buildMenuButton(
      ViewTransactionController controller, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        BudgetTextButton(
            label: controller.isEnabled ? 'Cancel' : 'Edit',
            onPressed: () => controller.isEnabled = !controller.isEnabled),
        const SizedBox(width: 10),
        BudgetTextButton(
            label: 'Delete',
            onPressed: () {
              const String message = 'Are you sure you want to delete?';
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
    );
  }

  /// Build date field
  ///
  Container _buildDateField(ViewTransactionController controller) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3,
            offset: Offset(0, 3),
          )
        ],
        border: Border.all(
            color: controller.isEnabled ?? true
                ? Colors.purple
                : Colors.grey[400]),
      ),
      child: BudgetDateSelectorButton(
          text:
              '${controller.selectedDate.month.toString().padLeft(2, "0")}/${controller.selectedDate.day.toString().padLeft(2, "0")}/${controller.selectedDate.year}',
          enabled: controller.isEnabled,
          selectedDate: controller.selectedDate,
          dateCallBack: (DateTime dateTime) {
            controller.selectedDate = dateTime;
          }),
    );
  }
}
