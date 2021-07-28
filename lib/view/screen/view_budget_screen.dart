import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:mybudget/util/id_util.dart';
import 'package:mybudget/view/dialog/budget_dialog.dart';
import 'package:mybudget/view/dialog/confirmation_dialog.dart';
import 'package:mybudget/view/dialog/success_dialog.dart';

import '../../controller/view_budget_controller.dart';
import '../../routes.dart';
import '../widget/budget_button.dart';
import '../widget/budget_field_label.dart';
import '../widget/budget_text_button.dart';
import '../widget/budget_text_field.dart';
import 'template_screen.dart';

class ViewBudgetScreen extends TemplateScreen {
  ViewBudgetScreen(
    this.controller,
  );

  final ViewBudgetController controller;

  @override
  Widget getLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
        final ViewBudgetController controller = Get.find();
        controller.resetPage();
        Navigator.pop(context);
      });

  @override
  Widget get title => const Text('Budget Account');

  /// Build body
  ///
  @override
  Widget buildBody(BuildContext context) {
    return _buildContent(controller, context);
  }

  /// Build content
  ///
  Widget _buildContent(ViewBudgetController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0.0, 40, 10),
      child: SingleChildScrollView(
        child: GetBuilder<ViewBudgetController>(
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
  Widget _buildForm(ViewBudgetController controller, BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 28),
          _buildMenuButton(controller, context),
          const SizedBox(height: 30),
          const BudgetFieldLabel(label: 'Account name'),
          const SizedBox(height: 15),
          _buildAccountField(controller),
          const SizedBox(height: 30),
          const BudgetFieldLabel(label: 'Budget amount'),
          const SizedBox(height: 15),
          _buildAmountField(controller),
          const SizedBox(height: 30),
          _buildAutoDeductionField(controller),
          const SizedBox(height: 30),
          _buildButton(controller, context),
        ],
      ),
    );
  }

  /// Build button
  ///
  Widget _buildButton(ViewBudgetController controller, BuildContext context) {
    return BudgetButton(
        controller.isEnabled
            ? () async {
                if (controller.isAutoDeduct) {
                  showBudgetDialog(
                      context: context,
                      title: 'Confirmation Dialog',
                      description:
                          'Are you sure you want to update with auto-deduction? This will erase all your transaction under this account for the current month.',
                      showButton1: true,
                      showButton2: true,
                      button1Title: 'Cancel',
                      button2Title: 'Yes',
                      onButton1Press: () => Navigator.pop(context),
                      onButton2Press: () async {
                        Navigator.pop(context);
                        await update(context, controller);
                      });
                } else {
                  await update(context, controller);
                }
              }
            : null,
        'Update');
  }

  /// Build auto-deduct field
  ///
  Row _buildAutoDeductionField(ViewBudgetController controller) {
    print('from screen:${controller.isAutoDeduct}');
    return Row(
      children: <Widget>[
        const BudgetFieldLabel(label: 'Auto-deduction'),
        Checkbox(
            value: controller.isAutoDeduct,
            onChanged: (bool value) => controller.isAutoDeduct = value),
      ],
    );
  }

  /// Build amount field
  ///
  BudgetTextField _buildAmountField(ViewBudgetController controller) {
    return BudgetTextField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputFormatterList: <FilteringTextInputFormatter>[
          if (controller.isEnabled)
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        isEnabled: controller.isEnabled,
        hintText: 'e.g. 1000',
        validator: controller.textFieldValidator,
        controller: controller.formattedBudgetAmount());
  }

  /// Build account field
  ///
  BudgetTextField _buildAccountField(ViewBudgetController controller) {
    return BudgetTextField(
        isEnabled: controller.isEnabled,
        hintText: 'e.g Electric bill',
        validator: controller.textFieldValidator,
        controller: controller.accountNameController);
  }

  /// Build menu button
  ///
  Widget _buildMenuButton(ViewBudgetController controller, BuildContext context) {
    return controller.account.summaryId != monthlySummaryID()
        ? Container()
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              BudgetTextButton(
                  label: controller.isEnabled ? 'Cancel' : 'Edit',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    controller.edit();
                  }),
              const SizedBox(width: 20),
              BudgetTextButton(
                  label: 'Delete',
                  onPressed: () {
                    const String message = 'Are you sure you want to delete?';
                    showConfirmationDialog(
                      context: context,
                      message: message,
                      yes: () {
                        controller.deleteAccount();
                        controller.resetPage();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      cancel: () => Navigator.pop(context),
                    );
                  }),
            ],
          );
  }

  /// A function for updating record
  ///
  Future<void> update(
      BuildContext context, ViewBudgetController controller) async {
    if (await controller.updateAccount()) {
      const String message = 'Account has been updated!';
      showSuccessDialog(
          context: context,
          close: () {
            Navigator.pop(context);
            Routes.pop(navigator: Routes.homeNavigator);
          },
          message: message);
    }
  }
}
