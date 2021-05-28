import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
              : Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0.0, 40, 10),
                  child: SingleChildScrollView(
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 58),
                          _buildDatefield(controller),
                          const SizedBox(height: 32),
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
                          BudgetTextField(
                              controller: controller.remarksController,
                              hintText: 'Enter Add Remarks'),
                          const SizedBox(height: 30),
                          const SizedBox(height: 30),
                          BudgetButton(() async {
                            if (await controller.save()) {
                              showAddTransactionSuccessDialog(
                                  context: context,
                                  close: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    Navigator.pop(context);
                                  },
                                  addAnother: () =>
                                      Navigator.of(context, rootNavigator: true)
                                          .pop(),
                                  title: controller.selectedAccount.title,
                                  amount: controller.amountController.text,
                                  remarks: controller.remarksController.text);
                              controller.resetFields();
                            }
                          }, 'Save'),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }

  BudgetTextField _buildAmountField(AddTransactionController controller) {
    return BudgetTextField(
      controller: controller.amountController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputFormatterList: <FilteringTextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      hintText: 'Enter Amount',
      validator: controller.textFieldValidator,
    );
  }

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
