import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //SAMPLE DATA
    //
    //
    List<MonthlyBudgetModel> monthlyBudgetList = [
      //BUDGET 1
      MonthlyBudgetModel(
        month: 'April',
        year: '2021',
        budgetList: [
          BudgetModelSample(
              title: 'Appartment Rental', budget: 5000.0, expense: 3000.0),
          BudgetModelSample(title: 'Food', budget: 4000.0, expense: 3000.0),
          BudgetModelSample(
              title: 'Motorcycle Bill', budget: 5000.0, expense: 3000.0),
          BudgetModelSample(title: 'Others', budget: 5000.0, expense: 3000.0),
          BudgetModelSample(
              title: 'Appartment Rental', budget: 5000.0, expense: 3000.0),
        ],
      ),
      //BUDGET 2
      MonthlyBudgetModel(month: 'March', year: '2021', budgetList: [
        BudgetModelSample(
            title: 'Appartment Rental', budget: 5000.0, expense: 3000.0),
        BudgetModelSample(title: 'Food', budget: 4000.0, expense: 3000.0),
        BudgetModelSample(
            title: 'Motorcycle Bill', budget: 5000.0, expense: 3000.0),
        BudgetModelSample(
            title: 'Appartment Rental', budget: 5000.0, expense: 3000.0),
      ]),

      //BUDGET 3
      MonthlyBudgetModel(month: 'February', year: '2021', budgetList: [
        BudgetModelSample(
            title: 'Motorcycle Bill', budget: 5000.0, expense: 3000.0),
        BudgetModelSample(title: 'Others', budget: 5000.0, expense: 3000.0),
        BudgetModelSample(
            title: 'Appartment Rental', budget: 5000.0, expense: 3000.0),
      ]),
    ];

    return PageView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      children: [
        for (int i = 0; i < monthlyBudgetList.length; i++)
          HomePageTemplate(monthlyBudgetModel: monthlyBudgetList[i], index: i)
      ],
    );
  }
}

class HomePageTemplate extends StatelessWidget {
  final MonthlyBudgetModel monthlyBudgetModel;
  final int index;

  const HomePageTemplate(
      {Key key, @required this.monthlyBudgetModel, @required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.purple[800],
        child: SafeArea(
          child: Stack(
            children: [
              //HEADER
              //
              //CURRENT MONTH
              if (index == 0)
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              Icon(
                                Icons.ac_unit,
                                size: 50,
                                color: Colors.white,
                              ),
                              SizedBox(width: 15),
                              Text(
                                'myBudget',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.add_circle,
                            color: Colors.purple[100],
                            size: 50,
                          )),
                    ],
                  ),
                ),
              //PREVIOUS MONTH
              if (index != 0)
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              Text(
                                '${monthlyBudgetModel.month} ${monthlyBudgetModel.year}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.double_arrow_rounded,
                            color: Colors.black,
                            size: 40,
                          )),
                    ],
                  ),
                ),
              //BODY
              Container(
                margin: EdgeInsets.only(top: 80),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  children: [
                    //(BUDGET - EXPENSE) VALUE
                    Container(
                      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300].withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 4), // changes position of shadow
                            ),
                          ]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                amountFormatter(
                                    budget(monthlyBudgetModel.budgetList)),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text(
                                '/',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text(
                                amountFormatter(
                                    expense(monthlyBudgetModel.budgetList)),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          // (BUDGET - EXPENSE) LABEL
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Budget',
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(width: 10),
                              Text(
                                '/',
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Expense',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          //(BALANCE) VALUE
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    'Php',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    amountFormatter(budget(
                                            monthlyBudgetModel.budgetList) -
                                        expense(monthlyBudgetModel.budgetList)),
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: Text(
                              'Balance',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              return BudgetItem(
                                index: index,
                                budget: monthlyBudgetModel.budgetList[index],
                                isLoading: index ==
                                    monthlyBudgetModel.budgetList.length - 1,
                              );
                            },
                            itemCount: monthlyBudgetModel.budgetList.length),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double budget(List<BudgetModelSample> items) {
    double result = 0.0;
    items.forEach((budget) {
      result += budget.budget;
    });
    return result;
  }

  double expense(List<BudgetModelSample> items) {
    double result = 0.0;

    items.forEach((budget) {
      result += budget.expense;
    });

    return result;
  }

  String amountFormatter(double amount) {
    NumberFormat formatter = NumberFormat('#,##,000');
    return formatter.format(amount);
  }
}

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
              //IMAGE
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
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
                        ],
                      ),
                    ),
                    //Budget
                    SizedBox(height: 5),
                    Container(
                      child: Text(
                        'Budget: ₱ ${amountFormatter(budget.budget)}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    //EXP
                    SizedBox(height: 5),
                    Container(
                      child: Row(
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
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Divider(),
        ),
        if (isLoading ?? false)
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            child: CircularProgressIndicator(),
          )
      ],
    );
  }

  String amountFormatter(double amount) {
    NumberFormat formatter = NumberFormat('#,##,000');
    return formatter.format(amount);
  }
}

//SAMPLE MODELS
//
//
class MonthlyBudgetModel {
  final List<BudgetModelSample> budgetList;
  final String month;
  final String year;

  MonthlyBudgetModel({
    @required this.month,
    @required this.year,
    @required this.budgetList,
  });
}

class BudgetModelSample {
  final String title;
  final double budget;
  final double expense;

  BudgetModelSample({
    @required this.title,
    @required this.budget,
    @required this.expense,
  });
}
