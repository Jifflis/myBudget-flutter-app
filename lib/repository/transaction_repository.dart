import 'package:mybudget/constant/db_keys.dart';
import 'package:mybudget/model/filter.dart';
import 'package:mybudget/model/transaction.dart';
import 'package:mybudget/resources/local_provider.dart';

class TransactionRepository {
  factory TransactionRepository() => _instance;

  TransactionRepository._();

  static final TransactionRepository _instance = TransactionRepository._();

  final LocalProvider _localProvider = LocalProvider();

  Future<List<Transaction>> getTransactions(List<Filter> filters) async {
    final Map<String, dynamic> filter = Filter.generateFilter(filters);

    if(filter==null){
      return <Transaction>[];
    }

    print(filter['where']);
    print(filter['whereArgs'].toString());

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
    return await _localProvider.delete<Transaction>(
        where: '${DBKey.TRANSACTION_ID}=?',
        whereArgs: <dynamic>[transactionID]);
  }
}
