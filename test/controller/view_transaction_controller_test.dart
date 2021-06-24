import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mybudget/controller/view_transaction_controller.dart';
import 'package:mybudget/enum/transaction_type.dart';
import 'package:mybudget/model/account.dart';
import 'package:mybudget/model/transaction.dart';
import 'package:mybudget/repository/acount_repository.dart';
import 'package:mybudget/repository/transaction_repository.dart';

import 'view_transaction_controller_test.mocks.dart';

@GenerateMocks(<Type>[TransactionRepository, AccountRepository])
void main() {
  group('View Transaction Controller', () {
    final TransactionRepository transactionRepository =
        MockTransactionRepository();
    final AccountRepository accountRepository = MockAccountRepository();

    final ViewTransactionController controller = ViewTransactionController(
      transactionRepository: transactionRepository,
      accountRepository: accountRepository,
    );

    final Account account = Account(
      accountId: 'accountid',
      title: 'accountTitle',
      summaryId: 'summaryId',
      userId: 'userid',
      budget: 1000,
      expense: 500,
      income: 2000,
    );

    final Transaction transaction = Transaction(
        transactionID: 'transactionId',
        userID: 'userId',
        accountID: 'accountId',
        remarks: 'remarks',
        amount: 100,
        transactionType: TransactionType.expense.valueString,
        account: account);

    controller.getParams(transaction);

    group('Update Transaction', () {
      test('No changes in transaction type the expense should be 450', () {
        when(transactionRepository.upsert(transaction))
            .thenAnswer((dynamic realInvocation) => null);
        when(accountRepository.upsert(account))
            .thenAnswer((dynamic realInvocation) => null);

        const double expectedExpense = 450;
        controller.amountController.text = '50';
        controller.updateTransaction();
        expect(controller.transaction.account.expense, expectedExpense);
      });

      test('No changes in transaction type the income should be 450', () {
        when(transactionRepository.upsert(transaction))
            .thenAnswer((dynamic realInvocation) => null);
        when(accountRepository.upsert(account))
            .thenAnswer((dynamic realInvocation) => null);

        controller.transaction.transactionType =
            TransactionType.income.valueString;
        controller.transactionType = TransactionType.income;
        controller.transaction.account.income = 500;
        controller.transaction.amount = 100;

        const double expectedIncome = 450;
        controller.amountController.text = '50';

        controller.updateTransaction();
        expect(controller.transaction.account.income, expectedIncome);
      });

      test(
          'A changes from expense to income the income should be 1050 and expense is 400',
          () {
        when(transactionRepository.upsert(transaction))
            .thenAnswer((dynamic realInvocation) => null);
        when(accountRepository.upsert(account))
            .thenAnswer((dynamic realInvocation) => null);

        controller.transaction.transactionType =
            TransactionType.expense.valueString;
        controller.transactionType = TransactionType.income;
        controller.transaction.account.expense = 500;
        controller.transaction.account.income = 1000;
        controller.transaction.amount = 100;
        controller.amountController.text = '50';

        const double expectedIncome = 1050;
        const double expectedExpense = 400;

        controller.updateTransaction();

        expect(controller.transaction.account.expense, expectedExpense);
        expect(controller.transaction.account.income, expectedIncome);
      });

      test(
          'A changes from income to expense the income should be 900 and expense is 550',
          () {
        when(transactionRepository.upsert(transaction))
            .thenAnswer((dynamic realInvocation) => null);
        when(accountRepository.upsert(account))
            .thenAnswer((dynamic realInvocation) => null);

        controller.transaction.transactionType =
            TransactionType.income.valueString;
        controller.transactionType = TransactionType.expense;
        controller.transaction.account.expense = 500;
        controller.transaction.account.income = 1000;
        controller.transaction.amount = 100;
        controller.amountController.text = '50';

        const double expectedIncome = 900;
        const double expectedExpense = 550;

        controller.updateTransaction();

        expect(controller.transaction.account.expense, expectedExpense);
        expect(controller.transaction.account.income, expectedIncome);
      });
    });
  });
}
