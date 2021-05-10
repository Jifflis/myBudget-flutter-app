import 'package:get/get.dart';
import 'package:mybudget/model/account.dart';
import 'package:mybudget/model/monthly_summary.dart';

class HomeController extends GetxController {
  List<MonthlySummary> monthlyBudgetList = <MonthlySummary>[
    MonthlySummary(
      month: 2,
      year: 2021,
      expense: 12003,
      budget: 40000,
      balance: 10000,
      accountList: <Account>[
        Account(
            title: 'Appartment Rental',
            budget: 5000.0,
            expense: 3000.0,
            accountId: null,
            userId: null,
            summaryId: null),
        Account(
            title: 'Food',
            budget: 4000.0,
            expense: 3000.0,
            accountId: null,
            userId: null,
            summaryId: null),
        Account(
            title: 'Motorcycle Bill',
            budget: 5000.0,
            expense: 3000.0,
            accountId: null,
            userId: null,
            summaryId: null),
        Account(
            title: 'Others',
            budget: 5000.0,
            expense: 3000.0,
            accountId: null,
            userId: null,
            summaryId: null),
        Account(
            title: 'Appartment Rental',
            budget: 5000.0,
            expense: 3000.0,
            accountId: null,
            userId: null,
            summaryId: null),
      ],
    ),
    //BUDGET 2
    MonthlySummary(
      month: 3,
      year: 2021,
      expense: 19000,
      budget: 40000,
      balance: 1000,
      accountList: <Account>[
        Account(
            title: 'Appartment Rental',
            budget: 5000.0,
            expense: 3000.0,
            accountId: null,
            userId: null,
            summaryId: null),
        Account(
            title: 'Food',
            budget: 4000.0,
            expense: 3000.0,
            accountId: null,
            userId: null,
            summaryId: null),
        Account(
            title: 'Motorcycle Bill',
            budget: 5000.0,
            expense: 3000.0,
            accountId: null,
            userId: null,
            summaryId: null),
        Account(
            title: 'Appartment Rental',
            budget: 5000.0,
            expense: 3000.0,
            accountId: null,
            userId: null,
            summaryId: null),
      ],
    ),

    //BUDGET 3
    MonthlySummary(
      month: 4,
      year: 2021,
      budget: 40000,
      balance: 10000,
      expense: 19000,
      accountList: <Account>[
        Account(
            title: 'Motorcycle Bill',
            budget: 5000.0,
            expense: 3000.0,
            accountId: null,
            userId: null,
            summaryId: null),
        Account(
            title: 'Others',
            budget: 5000.0,
            expense: 3000.0,
            accountId: null,
            userId: null,
            summaryId: null),
        Account(
            title: 'Appartment Rental',
            budget: 5000.0,
            expense: 3000.0,
            accountId: null,
            userId: null,
            summaryId: null),
      ],
    ),
  ];
}
