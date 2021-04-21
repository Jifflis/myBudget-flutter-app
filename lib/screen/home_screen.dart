import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybudget/controller/home_controller.dart';
import 'package:mybudget/util/number_util.dart';

import '../constant/custom_colors.dart';
import '../model/account.dart';
import '../model/ledger.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return PageView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      children: [
        for (int i = 0; i < controller.monthlyBudgetList.length; i++)
          HomePageTemplate(
            monthlyBudgetModel: controller.monthlyBudgetList[i],
            index: i,
          )
      ],
    );
  }
}


/// Homepage Template
///
///
class HomePageTemplate extends StatelessWidget {
  final MonthlyBudgetModel monthlyBudgetModel;
  final int index;

  const HomePageTemplate(
      {Key key, @required this.monthlyBudgetModel, @required this.index,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        _getLeadingIcon(index),
        _getTitle(index, monthlyBudgetModel),
        _getActionIcon(index),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.purple[800],
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 8),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              children: [
                _headerSection(monthlyBudgetModel),
                _divider(),
                _items(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  /// set app bar
  ///
  ///
  Widget appBar(Icon leading, String title, Icon action) {
    return AppBar(
      backgroundColor: Colors.purple[800],
      title: Text(title),
      leading: leading,
      actions: [action],
      elevation: 0,
    );
  }


  /// get appbar action icon
  ///
  ///
  Widget _getActionIcon(int index) {
    return index == 0
        ? Icon(
            Icons.add_circle,
            color: Colors.purple[100],
            size: 38,
          )
        : Icon(
            Icons.double_arrow_rounded,
            color: Colors.black,
            size: 38,
          );
  }


  ///get appbar leading icon
  ///
  ///
  Widget _getLeadingIcon(int index) {
    return index == 0
        ? Icon(
            Icons.ac_unit,
            color: Colors.purple[100],
            size: 32,
          )
        : null;
  }


  /// get appbar title
  ///
  ///
  String _getTitle(int index, MonthlyBudgetModel model) {
    return index == 0 ? 'myBudget' : '${model.month} ${model.year}';
  }


  ///  divider with drop down shadow
  ///
  ///
  Widget _divider() => Container(
        height: 1,
        width: double.infinity,
        decoration: BoxDecoration(
          color: CustomColors.gray9,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: .5,
              blurRadius: 4,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
      );


  /// header section
  ///
  ///
  Widget _headerSection(MonthlyBudgetModel model) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            '${amountFormatter(model.budget)}  / ${amountFormatter(model.expense)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Budget / Expense',
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Php',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                '${amountFormatter(model.balance)}',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            'Balance',
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 15),
        ],
      );


  /// Details section
  ///
  ///
  Widget _items() => Expanded(
        child: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          child: ListView.builder(
              itemBuilder: (context, index) {
                return BudgetItem(
                  index: index,
                  budget: monthlyBudgetModel.budgetList[index],
                  isLoading: index == monthlyBudgetModel.budgetList.length - 1,
                );
              },
              itemCount: monthlyBudgetModel.budgetList.length),
        ),
      );
}


/// Budget Item
///
///
class BudgetItem extends StatelessWidget {
  final int index;
  final bool isLoading;
  final BudgetModelSample budget;

  const BudgetItem(
      {Key key, @required this.index, @required this.budget, this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _leading(),
              SizedBox(width: 10),
              _content(),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Divider(),
        ),
      ],
    );

    //testing
  }


  /// leading
  ///
  ///
  Widget _leading() => Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      );


  /// title
  ///
  ///
  Widget _title() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TITLE
          Expanded(
            flex: 3,
            child: Container(
              child: Text('${budget.title}',
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
              child: Text(
                'View',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          SizedBox(height: 5),
        ],
      );


  /// subtitle
  ///
  ///
  Widget _subTitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Budget: ₱ ${amountFormatter(budget.budget)}',
            style: TextStyle(fontSize: 12),
          ),
          //EXP
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  'Exp: ₱ ${amountFormatter(budget.expense)}',
                  style: TextStyle(fontSize: 12),
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
  Widget _content() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            _subTitle(),
          ],
        ),
      );
}
