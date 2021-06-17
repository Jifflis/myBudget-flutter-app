import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybudget/enum/transaction_type.dart';
import 'package:mybudget/view/widget/radio_label.dart';

import '../../controller/add_transaction_controller.dart';
import '../../enum/status.dart';
import '../../model/account.dart';
import '../../repository/acount_repository.dart';
import '../../repository/transaction_repository.dart';
import '../dialog/add_transaction_success_dialog.dart';
import '../widget/add_transaction_dropdown.dart';
import '../widget/budget_button.dart';
import '../widget/budget_date_selector_button.dart';
import '../widget/budget_field_label.dart';
import '../widget/budget_text_field.dart';
import 'template_screen.dart';

class AddTransactionScreen extends TemplateScreen {
  @override
  Widget getLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () => Navigator.pop(context),
      );

  @override
  Widget get title => const Text('Add Transaction');

  @override
  Widget buildBody(BuildContext context) {
    final Account account =
        ModalRoute.of(context).settings.arguments as Account;

    final AddTransactionController controller = Get.put(
      AddTransactionController(
        transactionRepository: TransactionRepository(),
        accountRepository: AccountRepository(),
      ),
    );
    controller.getParams(account);

    return GetBuilder<AddTransactionController>(
        init: controller,
        builder: (_) {
          return controller.status == Status.LOADING
              ? Container()
              : _buildContent(controller, context);
        });
  }

  /// Build Content
  ///
  Padding _buildContent(
      AddTransactionController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0.0, 40, 10),
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 32),
              _buildDatefield(controller),
              const SizedBox(height: 24),
              const BudgetFieldLabel(
                label: 'Transaction Type',
                fontSize: 18,
              ),
              _buildSwitcherMenu(),
              const SizedBox(height: 15),
              const BudgetFieldLabel(label: 'Budget Account'),
              const SizedBox(height: 15),
              _buildDropdown(controller),
              const SizedBox(height: 15),
              const BudgetFieldLabel(label: 'Amount'),
              const SizedBox(height: 15),
              _buildAmountField(controller),
              const SizedBox(height: 30),
              const BudgetFieldLabel(label: 'Add Remarks'),
              const SizedBox(height: 15),
              _buildRemarksField(controller),
              const SizedBox(height: 30),
              const SizedBox(height: 30),
              _buildButton(controller, context),
            ],
          ),
        ),
      ),
    );
  }

  BudgetTextField _buildRemarksField(AddTransactionController controller) {
    return BudgetTextField(
        controller: controller.remarksController,
        hintText: 'e.g. Electric bill payment');
  }

  Widget _buildSwitcherMenu() => GetBuilder<AddTransactionController>(
        builder: (AddTransactionController controller) => Container(
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

  /// Build Button
  ///
  BudgetButton _buildButton(
      AddTransactionController controller, BuildContext context) {
    return BudgetButton(() async {
      if (await controller.save()) {
        showAddTransactionSuccessDialog(
            context: context,
            close: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pop(context);
            },
            addAnother: () => Navigator.of(context, rootNavigator: true).pop(),
            title: controller.selectedAccount.title,
            amount: controller.amountController.text,
            remarks: controller.remarksController.text);
        controller.resetFields();
      }
    }, 'Save');
  }

  /// Build amount field
  ///
  BudgetTextField _buildAmountField(AddTransactionController controller) {
    return BudgetTextField(
      controller: controller.amountController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputFormatterList: <FilteringTextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      hintText: 'e.g. 500',
      validator: controller.textFieldValidator,
    );
  }

  /// Build dropdown
  ///
  AddTransactionDropdown<Account> _buildDropdown(
      AddTransactionController controller) {
    return AddTransactionDropdown<Account>(
      list: controller.accountList,
      selected: controller.selectedAccount,
      onChange: (Account value) {
        controller.selectedAccount = value;
      },
    );
  }

  /// Build date field
  ///
  Row _buildDatefield(AddTransactionController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        BudgetDateSelectorButton(
          text:
              '${controller.selectedDate.month.toString().padLeft(2, "0")}/${controller.selectedDate.day.toString().padLeft(2, "0")}/${controller.selectedDate.year}',
          selectedDate: controller.selectedDate,
          dateCallBack: (DateTime dateTime) {
            controller.selectedDate = dateTime;
          },
          fontSize: 18,
        ),
      ],
    );
  }
}
