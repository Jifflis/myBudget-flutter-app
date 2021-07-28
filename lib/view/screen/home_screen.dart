import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mybudget/util/id_util.dart';
import 'package:oktoast/oktoast.dart';

import '../../constant/custom_colors.dart';
import '../../controller/home_controller.dart';
import '../../enum/status.dart';
import '../../model/account.dart';
import '../../model/monthly_summary.dart';
import '../../routes.dart';
import '../../util/color_util.dart';
import '../../util/date_util.dart';
import '../../util/number_util.dart';
import '../../view/screen/template_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      body: GetBuilder<HomeController>(
        init: controller,
        builder: (_) {
          return controller.status == Status.LOADING
              ? Container()
              : PageViewer(controller: controller);
        },
      ),
    );
  }
}

/// PageViewer
///
///
class PageViewer extends StatelessWidget {
  const PageViewer({Key key, @required this.controller}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller.pageController,
      scrollDirection: Axis.horizontal,
      reverse: true,
      children: <Widget>[
        ...controller.monthlyBudgetList
            .map(
              (MonthlySummary e) => HomePageTemplate(
                monthlyBudgetModel: e,
                index: controller.monthlyBudgetList.indexOf(e),
                pageController: controller.pageController,
              ),
            )
            .toList(),
      ],
    );
  }
}

/// Homepage Template
///
///
class HomePageTemplate extends TemplateScreen {
  HomePageTemplate({
    @required this.monthlyBudgetModel,
    @required this.index,
    @required this.pageController,
  });

  final MonthlySummary monthlyBudgetModel;
  final int index;
  final PageController pageController;

  @override
  Widget get title => Text(_buildTitle(index, monthlyBudgetModel));

  @override
  List<Widget> get appBarActions =>
      <Widget>[_buildAction(index, pageController)];

  @override
  Widget get leading => _buildLeading(index);

  @override
  Widget buildBody(BuildContext context) {
    final HomeController controller = Get.find();
    return Column(
      children: <Widget>[
        _buildHeader(monthlyBudgetModel, controller.getCurrency()),
        _buildDivider(),
        _buildItems(controller.getCurrency()),
      ],
    );
  }

  /// get appbar action icon
  ///
  ///
  Widget _buildAction(int index, PageController controller) {
    return index == 0
        ? Padding(
            padding: const EdgeInsets.only(right: 17),
            child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.purple[100],
                  size: 38,
                ),
                onPressed: () {
                  Routes.pushNamed(Routes.SCREEN_ADD_BUDGET,
                          navigator: Routes.homeNavigator)
                      .then((_) {
                    final HomeController controller = Get.find();
                    controller.updateCurrentMonthlyBudgetList();
                  });
                }),
          )
        : Padding(
            padding: const EdgeInsets.only(right: 17),
            child: IconButton(
              onPressed: () {
                pageController.animateToPage(0,
                    duration: const Duration(milliseconds: 200),
                    curve: const SawTooth(1));
              },
              icon: const Icon(
                Icons.double_arrow,
                color: Colors.white,
                size: 24,
              ),
            ),
          );
  }

  ///get appbar leading icon
  ///
  ///
  Widget _buildLeading(int index) {
    return index == 0
        ? Container(
            padding: const EdgeInsets.only(left: 5),
            child: SvgPicture.asset(
              'images/logo.svg',
            ),
          )
        : null;
  }

  /// get appbar title
  ///
  ///
  String _buildTitle(int index, MonthlySummary model) {
    return index == 0 ? 'My Budget' : '${getMonth(model.month)} ${model.year}';
  }

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

  /// header section
  ///
  ///
  Widget _buildHeader(MonthlySummary model, String currency) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                currency,
                style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                '${amountFormatter(model.balance)}   ',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                  color: balanceColorIndicator(
                    budget: model.budget,
                    balance: model.balance,
                  ),
                ),
              ),
            ],
          ),
          const Text(
            'Balance',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 1,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 45),
            child: Divider(
              color: CustomColors.gray5,
              thickness: 2,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                currency,
                style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                amountFormatter(model.budget),
                style: const TextStyle(fontSize: 18, letterSpacing: 1),
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'budget',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${amountFormatter(model.income)}  / ${amountFormatter(model.expense)}',
            style: const TextStyle(
              fontSize: 18,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Income / Expense',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 15),
        ],
      );

  /// Details section
  ///
  ///
  Widget _buildItems(String currency) => monthlyBudgetModel.accountList != null
      ? Expanded(
          child: Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (monthlyBudgetModel.monthlySummaryId !=
                          monthlySummaryID()) {
                        showToast(
                            'You must be in current month to do this action!');
                        return;
                      }

                      Routes.pushNamed(Routes.SCREEN_ADD_TRANSACTION,
                              navigator: Routes.homeNavigator,
                              arguments: monthlyBudgetModel.accountList[index])
                          .then((_) {
                        final HomeController controller = Get.find();
                        controller.updateCurrentMonthlyBudgetList();
                      });
                    },
                    child: BudgetItem(
                      index: index,
                      budget: monthlyBudgetModel.accountList[index],
                      currency: currency,
                      isLoading:
                          index == monthlyBudgetModel.accountList.length - 1,
                    ),
                  );
                },
                itemCount: monthlyBudgetModel.accountList.length),
          ),
        )
      : const Expanded(
          child: Center(
            child: Text(
              'No Data',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
            ),
          ),
        );
}

/// Budget Item
///
///
class BudgetItem extends StatelessWidget {
  const BudgetItem(
      {Key key,
      @required this.index,
      @required this.budget,
      this.isLoading,
      this.currency})
      : super(key: key);

  final int index;
  final bool isLoading;
  final Account budget;
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
          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildLeading(),
              const SizedBox(width: 10),
              _buildContent(),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: const Divider(),
        ),
      ],
    );

    //testing
  }

  /// leading
  ///
  ///
  Widget _buildLeading() => Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      );

  /// title
  ///
  ///
  Widget _buildTitle() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              child: Text(
                budget.title,
                style: TextStyle(
                  color: Colors.purple[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          //VIEW
          Expanded(
            flex: 1,
            child: Container(
              child: InkWell(
                onTap: () => Routes.pushNamed(Routes.SCREEN_VIEW_BUDGET,
                        navigator: Routes.homeNavigator, arguments: budget)
                    .then((_) {
                  final HomeController controller = Get.find();
                  controller.updateCurrentMonthlyBudgetList();
                }),
                child: const Text(
                  'View',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      color: CustomColors.gray),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      );

  /// subtitle
  ///
  ///
  Widget _buildSubtitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Budget: ${amountFormatter(budget.budget)}',
            style: const TextStyle(
              fontSize: 12,
              letterSpacing: .5,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Income: ${amountFormatter(budget.income)}',
            style: const TextStyle(
              fontSize: 12,
              letterSpacing: .5,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  'Expenses: ${amountFormatter(budget.expense)}',
                  style: const TextStyle(
                    fontSize: 12,
                    letterSpacing: .5,
                  ),
                ),
              ),
              Container(
                child: Text(
                  'Bal. ${amountFormatter(budget.budget - budget.expense)}',
                  style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1,
                      color: balanceColorIndicator(
                        budget: budget.budget,
                        balance: budget.balance,
                      ),
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          )
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
            const SizedBox(
              height: 8,
            ),
            _buildSubtitle(),
          ],
        ),
      );
}
