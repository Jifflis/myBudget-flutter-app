enum TransactionType {
  expense,
  income,
}

extension TransactionTypeExtension on TransactionType {
  String get valueString {
    switch (this) {
      case TransactionType.expense:
        return 'expense';
      default:
        return 'income';
    }
  }
}
