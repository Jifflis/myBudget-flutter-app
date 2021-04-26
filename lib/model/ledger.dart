import 'package:flutter/material.dart';

import 'account.dart';

class MonthlyBudgetModel {
  final List<Account> budgetList;
  final String month;
  final String year;

  double budget;
  double expense;
  double balance;

  MonthlyBudgetModel({
    @required this.month,
    @required this.year,
    @required this.budgetList,
    this.budget,
    this.balance,
    this.expense,
  });
}