import 'dart:collection';

import '../model/currency.dart';
import '../repository/currency_repository.dart';
import 'base_controller.dart';

class CurrencyController extends BaseController {
  final CurrencyRepository _currencyRepository = CurrencyRepository();

  List<Currency> _currencyList = <Currency>[];

  Currency _selectedCurrency;

  @override
  void onInit() {
    _initCurrencies();
    super.onInit();
  }

  /// Get unmodifiable [_currencyList]
  ///
  UnmodifiableListView<Currency> get currencyList =>
      UnmodifiableListView<Currency>(_currencyList);

  /// Get selected currency
  ///
  Currency get selectedCurrency => _selectedCurrency;

  /// Set selected currency
  ///
  set selectedCurrency(Currency currency) {
    _selectedCurrency = currency;
    update();
  }

  /// Initialize [_currencyList] data
  ///
  void _initCurrencies() {
    _currencyList = _currencyRepository.currencyList;
    _selectedCurrency = _currencyList[0];
  }
}
