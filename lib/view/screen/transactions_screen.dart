import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:mybudget/enum/transaction_type.dart';

import '../../constant/custom_colors.dart';
import '../../controller/home_controller.dart';
import '../../controller/transactions_controller.dart';
import '../../enum/status.dart';
import '../../enum/transaction_view_type.dart';
import '../../model/transaction.dart';
import '../../repository/transaction_repository.dart';
import '../../routes.dart';
import '../../util/date_util.dart';
import '../../util/number_util.dart';
import '../widget/budget_date_selector_button.dart';
import '../widget/budget_text_field_icon_button.dart';
import '../widget/radio_label.dart';
import 'template_screen.dart';

class TransactionsScreen extends TemplateScreen {
  /// Build title section
  ///
  @override
  Widget get title => GetBuilder<TransactionsController>(
        builder: (TransactionsController controller) =>
            BudgetDateSelectorButton(
          text: controller.getTitle(),
          fontSize: 20,
          selectedDate: controller.selectedDate,
          dateCallBack: (DateTime dateTime) {
            controller.selectedDate = dateTime;
          },
        ),
      );

  /// Build app bar actions
  ///
  @override
  List<Widget> get appBarActions => <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 17),
          child: IconButton(
            icon: Icon(
              Icons.add_circle,
              color: Colors.purple[100],
              size: 38,
            ),
            onPressed: () => Routes.pushNamed(Routes.SCREEN_ADD_TRANSACTION,
                    navigator: Routes.transactionNavigator)
                .then((_) {
              final TransactionsController controller = Get.find();
              controller.getTransactionList();

              final HomeController homeController = Get.find();
              homeController.updateCurrentMonthlyBudgetList();
            }),
          ),
        )
      ];

  /// Build body
  ///
  @override
  Widget buildBody(BuildContext context) {
    final TransactionsController controller = Get.put(
      TransactionsController(
        transactionRepository: TransactionRepository(),
      ),
    );
    controller.getTransactionList();

    return Column(
      children: <Widget>[
        _buildHeader(context, controller),
        _buildDivider(),
        GetBuilder<TransactionsController>(
          builder: (_) => _buildItems(controller),
        ),
      ],
    );
  }

  /// header section
  ///
  ///
  Widget _buildHeader(
          BuildContext context, TransactionsController controller) =>
      Container(
        padding: const EdgeInsets.fromLTRB(0, 14.0, 0, 0.0),
        height: 165,
        child: Column(
          children: <Widget>[
            _buildSwitcherMenu(),
            _buildSearchBar(controller),
            _buildDetailsMenu(),
          ],
        ),
      );

  /// Radion button
  ///
  Widget _buildSwitcherMenu() => GetBuilder<TransactionsController>(
        builder: (TransactionsController controller) => Container(
          margin: const EdgeInsets.only(left: 8, right: 12),
          child: Row(
            children: <Widget>[
              RadioLabel<TransactionViewType>(
                label: 'Day',
                value: TransactionViewType.day,
                groupValue: controller.transactionViewType,
                onChange: (TransactionViewType value) {
                  controller.transactionViewType = TransactionViewType.day;
                },
              ),
              const SizedBox(
                width: 12,
              ),
              RadioLabel<TransactionViewType>(
                label: 'Month',
                value: TransactionViewType.month,
                groupValue: controller.transactionViewType,
                onChange: (TransactionViewType value) {
                  controller.transactionViewType = TransactionViewType.month;
                },
              ),
              if (!controller.isCurrentDay)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          controller.viewTodayTransaction();
                        },
                        child: const Text('Today'),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      );

  /// search bar
  ///
  ///
  Widget _buildSearchBar(TransactionsController controller) => Container(
        padding: const EdgeInsets.only(right: 14, left: 16, top: 0),
        child: BudgetTextFieldIconButton(
          onChanged: controller.search,
          hintText: 'Search',
          iconData: Icons.search,
          onPressed: () {
            print('search test');
          },
        ),
      );

  /// Build details menu
  ///
  Widget _buildDetailsMenu() => GetBuilder<TransactionsController>(
        builder: (TransactionsController controller) => Container(
          margin: const EdgeInsets.only(left: 24, top: 5),
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        child: const Text(
                          'Income',
                          style: TextStyle(letterSpacing: .5),
                        ),
                      ),
                      Text(
                        ': ${controller.getCurrency().toLowerCase()} ${amountFormatter(controller.totalIncome)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        child: const Text(
                          'Expense',
                          style: TextStyle(letterSpacing: .5),
                        ),
                      ),
                      Text(
                        ': ${controller.getCurrency().toLowerCase()} ${amountFormatter(controller.totalExpense)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        controller.previous();
                      },
                      child: const Text(
                        'prev',
                        style: TextStyle(color: CustomColors.gray),
                      ),
                    ),
                    TextButton(
                      onPressed: controller.isCurrentDate
                          ? null
                          : () {
                              controller.next();
                            },
                      child: Text(
                        'next',
                        style: TextStyle(
                            color: controller.isCurrentDate
                                ? CustomColors.gray3
                                : CustomColors.gray),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  ///  divider with drop down shadow
  ///
  ///
  Widget _buildDivider() => Container(
        height: 1,
        width: double.infinity,
        decoration: BoxDecoration(
          color: CustomColors.gray9,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: .5,
              blurRadius: 4,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
      );

  /// Details section
  ///
  ///
  Widget _buildItems(TransactionsController controller) {
    return Expanded(
      child: controller.filteredTransaction.isEmpty
          ? Container(
              child: const Center(
                child: Text(
                  'No data...',
                  style: TextStyle(color: CustomColors.gray3),
                ),
              ),
            )
          : Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return TransactionItem(
                          index: index,
                          transaction: controller.filteredTransaction[index],
                          currency: controller.getCurrency(),
                        );
                      },
                      itemCount: controller.filteredTransaction.length),
                ),
                if (controller.status == Status.LOADING)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
    );
  }
}

/// Transaction Item
///
///
class TransactionItem extends StatelessWidget {
  const TransactionItem(
      {Key key,
      @required this.index,
      @required this.transaction,
      @required this.currency,
      this.isLoading})
      : super(key: key);

  final int index;
  final bool isLoading;
  final Transaction transaction;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (index == 0)
          const SizedBox(
            height: 17,
          ),
        Container(
          padding: const EdgeInsets.fromLTRB(15.0, 1.0, 15.0, 1.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildLeading(),
              const SizedBox(width: 10),
              _buildContent(),
              const SizedBox(width: 20),
              _buildAction(),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: const Divider(),
        ),
      ],
    );
  }

  /// leading
  ///
  ///
  Widget _buildLeading() => Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              dateSimplified(transaction.date.toString())['MM'],
              style: TextStyle(
                color: Colors.purple[800],
                fontSize: 12,
              ),
            ),
            Text(
              dateSimplified(transaction.date.toString())['DD'],
              style: TextStyle(
                  color: Colors.purple[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      );

  /// title
  ///
  ///
  Widget _buildTitle() {
    return Container(
      child: Text(
        transaction.account.title,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          letterSpacing: .5,
        ),
      ),
    );
  }

  /// subtitle
  ///
  ///
  Widget _buildSubtitle() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transaction.remarks == null || transaction.remarks.isEmpty
                        ? 'No remarks available'
                        : transaction.remarks,
                    style: const TextStyle(fontSize: 12, letterSpacing: .5),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Time ${DateFormat.Hm().format(transaction.date)}',
                    style: const TextStyle(fontSize: 12, letterSpacing: .5),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  /// content
  ///
  ///
  Widget _buildContent() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(),
            const SizedBox(height: 3),
            _buildSubtitle(),
          ],
        ),
      );

  /// action button
  ///
  ///
  Widget _buildAction() => InkWell(
        onTap: () {
          Routes.pushNamed(
            Routes.SCREEN_VIEW_TRANSACTION,
            navigator: Routes.transactionNavigator,
            arguments: transaction,
          ).then((_) {
            final TransactionsController controller = Get.find();
            controller.updateItem(transaction);

            final HomeController homeController = Get.find();
            homeController.updateCurrentMonthlyBudgetList();
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: const Icon(Icons.chevron_right_rounded),
            ),
            const SizedBox(
              height: 18,
            ),
            Container(
              child: Text(
                transaction.transactionType ==
                        TransactionType.expense.valueString
                    ? '( ${currency.toLowerCase()} ${amountFormatter(transaction.amount)} )'
                    : '${currency.toLowerCase()} ${amountFormatter(transaction.amount)}',
                style: TextStyle(
                  fontSize: 12,
                  color: transaction.transactionType ==
                          TransactionType.expense.valueString
                      ? Colors.red
                      : CustomColors.gray,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );
}
