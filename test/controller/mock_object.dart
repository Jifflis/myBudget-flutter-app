import 'package:mybudget/enum/transaction_type.dart';
import 'package:mybudget/model/account.dart';
import 'package:mybudget/model/transaction.dart';

final Account mockObjectAccount = Account(
  accountId: 'accountid',
  title: 'accountTitle',
  summaryId: 'summaryId',
  userId: 'userid',
  budget: 1000,
  expense: 500,
  income: 2000,
);

final Transaction mockObjectTransaction = Transaction(
    transactionID: 'transactionId',
    userID: 'userId',
    accountID: 'accountId',
    remarks: 'remarks',
    amount: 100,
    transactionType: TransactionType.expense.valueString,
    account: mockObjectAccount);