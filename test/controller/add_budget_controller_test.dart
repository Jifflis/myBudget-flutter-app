import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mybudget/controller/add_budget_controller.dart';
import 'package:mybudget/model/account.dart';
import 'package:mybudget/repository/acount_repository.dart';
import 'package:mybudget/repository/transaction_repository.dart';

import 'add_budget_controller_test.mocks.dart';
import 'mock_object.dart';

@GenerateMocks(<Type>[AccountRepository, TransactionRepository])
Future<void> main() async{
  final AccountRepository accountRepository = MockAccountRepository();
  final TransactionRepository transactionRepository =
      MockTransactionRepository();
  final AddBudgetController controller = AddBudgetController(
    accountRepository,
    transactionRepository,
  )..initializeUser = false;

  group('Add Budget Controller', () {
    group('Save Account', () {
      test(
          'if auto-deduction, expense should equal to budget and balance is zero',
          () async {
        final Account account = mockObjectAccount
          ..budget = 1000
          ..expense = 0
          ..income = 0
          ..autoDeduct = true;

        controller.isAutoDeduct = true;

        when(transactionRepository
                .upsert(any))
            .thenAnswer((dynamic realInvocation) => null);

        when(accountRepository.upsert(any))
            .thenAnswer((dynamic realInvocation) => null);

        when(accountRepository.getAccountByName(any))
            .thenAnswer((dynamic realInvocation) => null);

        await controller.save(account);
        expect(account.expense, account.budget);
        expect(account.balance, 0);
      });
    });
  });
}
