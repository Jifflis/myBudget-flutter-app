import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      BudgetModelSample(
          title: 'Appartment Rental', budget: 5000.0, expense: 3000.0),
      BudgetModelSample(title: 'Food', budget: 4000.0, expense: 3000.0),
      BudgetModelSample(
          title: 'Motorcycle Bill', budget: 5000.0, expense: 3000.0),
      BudgetModelSample(title: 'Others', budget: 5000.0, expense: 3000.0),
      BudgetModelSample(
          title: 'Appartment Rental', budget: 5000.0, expense: 3000.0),
    ];
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.purple[800],
        child: SafeArea(
          child: Stack(
            children: [
              //HEADER
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
              //BODY
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '30,000',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '/',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '10,000',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    // (BUDGET - EXPENSE) LABEL
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Budget'),
                        SizedBox(width: 10),
                        Text('/'),
                        SizedBox(width: 10),
                        Text('Expense'),
                      ],
                    ),
                    SizedBox(height: 20),

                    //(BALANCE) VALUE
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text('Php'),
                          ),
                          SizedBox(width: 10),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              '20,201',
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      child: Text('Balance'),
                    ),
                    SizedBox(height: 15),
                    Divider(height: 0.0),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              return BudgetItem(
                                index: index,
                                budget: items[index],
                                isLoading: index == items.length - 1,
                              );
                            },
                            itemCount: items.length),
                      ),
                    ),
                    //LIST
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //IMAGE
              Container(
                height: 65,
                width: 65,
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          //VIEW
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                'View',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 16,
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
                      child:
                          Text('Budget: ₱ ${amountFormatter(budget.budget)}'),
                    ),
                    //EXP
                    SizedBox(height: 5),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                                'Exp: ₱ ${amountFormatter(budget.expense)}'),
                          ),
                          Container(
                            child: Text(
                              'Bal: ₱ ${amountFormatter(budget.budget - budget.expense)}',
                              style: TextStyle(
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
        Divider(),
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
