import 'package:get/get.dart';

import '../model/account.dart';

class AddTransactionController extends GetxController {
  List<Account> accountList = <Account>[
    Account(title: 'Appartment Rental'),
    Account(title: 'Food'),
    Account(title: 'Fare'),
  ];
  Account _selectedAccount;

  @override
  void onInit() {
    _selectedAccount = accountList[0];
    super.onInit();
  }

  Account get selectedAccount => _selectedAccount;

  set selectedCurrency(Account account) {
    _selectedAccount = account;
    update();
  }
}
