import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../../constant/custom_colors.dart';
import '../../controller/home_controller.dart';
import '../../controller/transactions_controller.dart';
import '../../enum/status.dart';
import '../../model/transaction.dart';
import '../../repository/transaction_repository.dart';
import '../../routes.dart';
import '../../util/date_util.dart';
import '../../util/number_util.dart';
import '../dialog/filter_dialog.dart';
import '../widget/budget_text_field_icon_button.dart';
import 'template_screen.dart';

class TransactionsScreen extends TemplateScreen {
  @override
  String get title => 'Transaction';

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

  @override
  Widget buildBody(BuildContext context) {
    final TransactionsController controller = Get.put(
        TransactionsController(transactionRepository: TransactionRepository()));

    return Column(
      children: <Widget>[
        _buildHeader(context),
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
  Widget _buildHeader(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        height: 145,
        child: Row(
          children: <Widget>[
            _searchBar(),
            const SizedBox(width: 10),
            _filter(context),
          ],
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

  /// search bar
  ///
  ///
  Widget _searchBar() => Expanded(
        child: BudgetTextFieldIconButton(
          hintText: 'Search',
          iconData: Icons.search,
          onPressed: () {
            print('search test');
          },
        ),
      );

  /// filter button
  ///
  ///
  Widget _filter(BuildContext context) => InkWell(
        onTap: () {
          showFilterDialog(context, () {
            Routes.pop(navigator: Routes.transactionNavigator);
          });
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: const Icon(
            Icons.filter_alt_outlined,
            color: Colors.white,
            size: 35,
          ),
        ),
      );

  /// Details section
  ///
  ///
  Widget _buildItems(TransactionsController controller) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return TransactionItem(
                    index: index,
                    transaction: controller.transactions[index],
                    currency: controller.getCurrency(),
                  );
                },
                itemCount: controller.transactions.length),
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
          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
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
              dateSimplified(transaction.updatedAT.toString())['MM'],
              style: TextStyle(
                color: Colors.purple[800],
                fontSize: 12,
              ),
            ),
            Text(
              dateSimplified(transaction.updatedAT.toString())['DD'],
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
          Container(
            child: Text(
              transaction.remarks,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Container(
            child: Text(
              '$currency ${amountFormatter(transaction.amount)}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue[600],
                fontWeight: FontWeight.w400,
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
            const SizedBox(height: 10),
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
        child: Container(
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
      );
}
