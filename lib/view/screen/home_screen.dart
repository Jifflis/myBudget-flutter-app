import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mybudget/enum/status.dart';

import '../../constant/custom_colors.dart';
import '../../controller/home_controller.dart';
import '../../model/account.dart';
import '../../model/monthly_summary.dart';
import '../../routes.dart';
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
                : PageViewer(monthlyBudgetList: controller.monthlyBudgetList);
          }),
    );
  }
}

/// PageViewer
///
///
class PageViewer extends StatelessWidget {
  const PageViewer({Key key, @required this.monthlyBudgetList})
      : super(key: key);

  final List<MonthlySummary> monthlyBudgetList;

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      children: <Widget>[
        ...monthlyBudgetList
            .map(
              (MonthlySummary e) => HomePageTemplate(
                monthlyBudgetModel: e,
                index: monthlyBudgetList.indexOf(e),
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
  });

  final MonthlySummary monthlyBudgetModel;
  final int index;

  @override
  String get title => _buildTitle(index, monthlyBudgetModel);

  @override
  List<Widget> get appBarActions => <Widget>[_buildAction(index)];

  @override
  Widget get leading => _buildLeading(index);

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildHeader(monthlyBudgetModel),
        _buildDivider(),
        _buildItems(),
      ],
    );
  }

  /// get appbar action icon
  ///
  ///
  Widget _buildAction(int index) {
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
                      navigator: Routes.homeNavigator);
                }),
          )
        : const Padding(
            padding: EdgeInsets.only(right: 17),
            child: Icon(
              Icons.double_arrow_rounded,
              color: Colors.black,
              size: 38,
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
    return index == 0 ? 'myBudget' : '${model.month} ${model.year}';
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
  Widget _buildHeader(MonthlySummary model) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          Text(
            '${amountFormatter(model.budget)}  / ${amountFormatter(model.expense)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Budget / Expense',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Php',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                amountFormatter(model.balance),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Text(
            'Balance',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 15),
        ],
      );

  /// Details section
  ///
  ///
  Widget _buildItems() => monthlyBudgetModel.accountList != null
      ? Expanded(
          child: Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return BudgetItem(
                    index: index,
                    budget: monthlyBudgetModel.accountList[index],
                    isLoading:
                        index == monthlyBudgetModel.accountList.length - 1,
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
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
        );
}

/// Budget Item
///
///
class BudgetItem extends StatelessWidget {
  const BudgetItem(
      {Key key, @required this.index, @required this.budget, this.isLoading})
      : super(key: key);

  final int index;
  final bool isLoading;
  final Account budget;

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
              child: Text(budget.title,
                  style: TextStyle(
                      color: Colors.purple[800],
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          //VIEW
          Expanded(
            flex: 1,
            child: Container(
              child: InkWell(
                onTap: () => Routes.pushNamed(Routes.SCREEN_VIEW_TRANSACTION,
                    navigator: Routes.homeNavigator, arguments: budget),
                child: const Text(
                  'View',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
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
            'Budget: ₱ ${amountFormatter(budget.budget)}',
            style: const TextStyle(fontSize: 12),
          ),
          //EXP
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  'Exp: ₱ ${amountFormatter(budget.expense)}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              Container(
                child: Text(
                  'Bal: ₱ ${amountFormatter(budget.budget - budget.expense)}',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.pink[600],
                      fontWeight: FontWeight.bold),
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
            _buildSubtitle(),
          ],
        ),
      );
}
