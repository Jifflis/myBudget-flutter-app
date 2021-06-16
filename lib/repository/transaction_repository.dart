import 'package:mybudget/constant/general.dart';

import '../constant/db_keys.dart';
import '../model/filter.dart';
import '../model/transaction.dart';
import '../resources/local_provider.dart';

class TransactionRepository {
  factory TransactionRepository() => _instance;

  TransactionRepository._();

  static final TransactionRepository _instance = TransactionRepository._();

  final LocalProvider _localProvider = LocalProvider();

  Future<List<Transaction>> getTransactions(
  {String where,List<dynamic> whereArgs}) async {
    return await _localProvider.list<Transaction>(
        where: where,
        whereArgs: whereArgs,
        orderBy: '${DBKey.UPDATED_AT} desc');
  }

  Future<List<Transaction>> getTransactionsWithFilter(
      List<Filter> filters) async {
    final Map<String, dynamic> filter = Filter.generateFilter(filters);

    if (filter == null) {
      return <Transaction>[];
    }

    return await _localProvider.list<Transaction>(
        where: filter['where'],
        whereArgs: filter['whereArgs'],
        orderBy: 'id desc');
  }

  Future<void> upsert(Transaction transaction) async {
    await _localProvider.upsert<Transaction>(transaction);
  }

  Future<Transaction> getTransaction(String transactionID) async {
    return await _localProvider.get<Transaction>(
        where: '${DBKey.TRANSACTION_ID}=?',
        whereArgs: <dynamic>[transactionID]);
  }

  Future<void> delete(String transactionID) async {
    await _localProvider.delete<Transaction>(
      where: '${DBKey.TRANSACTION_ID}=?',
      whereArgs: <dynamic>[transactionID],
    );
  }

  Future<void> deleteAll(String accountID) async {
    await _localProvider.delete<Transaction>(
      where: '${DBKey.ACCOUNT_ID}=?',
      whereArgs: <dynamic>[accountID],
    );
  }

  Future<void> deleteSystemGeneratedTransaction(String accountID) async {
    await _localProvider.delete<Transaction>(
      where: '${DBKey.ACCOUNT_ID}=? and ${DBKey.REMARKS}=? ',
      whereArgs: <dynamic>[accountID,SYSTEM_GEN],
    );
  }
}
