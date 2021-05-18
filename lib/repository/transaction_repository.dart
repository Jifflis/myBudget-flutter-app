import 'package:mybudget/model/transaction.dart';
import 'package:mybudget/resources/local_provider.dart';

class TransactionRepository {
  factory TransactionRepository() => _instance;

  TransactionRepository._();

  static final TransactionRepository _instance = TransactionRepository._();

  final LocalProvider _localProvider = LocalProvider();

  Future<List<Transaction>> getTransactions() async {
    return await _localProvider.list<Transaction>(orderBy: 'id desc');
  }

  Future<void> upsert(Transaction transaction) async {
    await _localProvider.upsert<Transaction>(transaction);
  }
}
