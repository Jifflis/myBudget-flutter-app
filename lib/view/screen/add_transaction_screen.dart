import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybudget/controller/add_transaction_controller.dart';
import 'package:mybudget/enum/status.dart';
import 'package:mybudget/repository/acount_repository.dart';
import 'package:mybudget/repository/transaction_repository.dart';
import 'package:mybudget/view/widget/add_transaction_dropdown.dart';
import 'package:oktoast/oktoast.dart';

import '../../model/account.dart';
import '../widget/budget_button.dart';
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
  String get title => 'Add Transaction';

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
                          const BudgetFieldLabel(label: 'Budget Account'),
                          const SizedBox(height: 15),
                          AddTransactionDropdown<Account>(
                            list: controller.accountList,
                            selected: controller.selectedAccount,
                            onChange: (Account value) {
                              controller.selectedAccount = value;
                            },
                          ),
                          const SizedBox(height: 15),
                          const BudgetFieldLabel(label: 'Amount'),
                          const SizedBox(height: 15),
                          BudgetTextField(
                            controller: controller.amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            textInputFormatterList: <
                                FilteringTextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            hintText: 'Enter Amount',
                            validator: controller.textFieldValidator,
                          ),
                          const SizedBox(height: 30),
                          const BudgetFieldLabel(label: 'Add Remarks'),
                          const SizedBox(height: 15),
                          BudgetTextField(
                              controller: controller.remarksController,
                              hintText: 'Enter Add Remarks'),
                          const SizedBox(height: 30),
                          const SizedBox(height: 30),
                          BudgetButton(() async {
                            await controller.save()
                                ? showToast('Saving Success',
                                    position: ToastPosition.bottom)
                                : showToast('Saving failed',
                                    position: ToastPosition.bottom);
                          }, 'Save'),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}
