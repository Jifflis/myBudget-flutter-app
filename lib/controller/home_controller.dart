import 'package:get/get.dart';
import 'package:mybudget/model/account.dart';
import 'package:mybudget/model/ledger.dart';

class HomeController extends GetxController {
  List<MonthlyBudgetModel> monthlyBudgetList = <MonthlyBudgetModel>[
    //BUDGET 1
    MonthlyBudgetModel(
      month: 'April',
      year: '2021',
      expense: 12003,
      budget: 40000,
      balance: 10000,
      budgetList: <Account>[
        Account(
          title: 'Appartment Rental',
          budget: 5000.0,
          expense: 3000.0,
        ),
        Account(
          title: 'Food',
          budget: 4000.0,
          expense: 3000.0,
        ),
        Account(
          title: 'Motorcycle Bill',
          budget: 5000.0,
          expense: 3000.0,
        ),
        Account(
          title: 'Others',
          budget: 5000.0,
          expense: 3000.0,
        ),
        Account(
          title: 'Appartment Rental',
          budget: 5000.0,
          expense: 3000.0,
        ),
      ],
    ),
    //BUDGET 2
    MonthlyBudgetModel(
      month: 'March',
      year: '2021',
      expense: 19000,
      budget: 40000,
      balance: 1000,
      budgetList: <Account>[
        Account(
          title: 'Appartment Rental',
          budget: 5000.0,
          expense: 3000.0,
        ),
        Account(
          title: 'Food',
          budget: 4000.0,
          expense: 3000.0,
        ),
        Account(
          title: 'Motorcycle Bill',
          budget: 5000.0,
          expense: 3000.0,
        ),
        Account(
          title: 'Appartment Rental',
          budget: 5000.0,
          expense: 3000.0,
        ),
      ],
    ),

    //BUDGET 3
    MonthlyBudgetModel(
      month: 'February',
      year: '2021',
      budget: 40000,
      balance: 10000,
      budgetList:<Account>[
        Account(
          title: 'Motorcycle Bill',
          budget: 5000.0,
          expense: 3000.0,
        ),
        Account(
          title: 'Others',
          budget: 5000.0,
          expense: 3000.0,
        ),
        Account(
          title: 'Appartment Rental',
          budget: 5000.0,
          expense: 3000.0,
        ),
      ],
    ),
  ];
}
