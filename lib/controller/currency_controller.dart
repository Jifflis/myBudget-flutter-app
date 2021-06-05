import 'dart:collection';

import 'package:mybudget/enum/status.dart';
import 'package:mybudget/model/settings.dart';
import 'package:mybudget/model/user.dart';
import 'package:mybudget/repository/settings_repository.dart';

import '../model/currency.dart';
import '../repository/currency_repository.dart';
import 'base_controller.dart';

class CurrencyController extends BaseController {
  CurrencyController() : super(provideSettings: false);
  final CurrencyRepository _currencyRepository = CurrencyRepository();
  final SettingsRepository _settingsRepository = SettingsRepository();
  List<Currency> _currencyList = <Currency>[];

  Currency _selectedCurrency;
  String currency;
  int currencyIndex;

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

  Future<Status> save() async {
    status = Status.LOADING;
    await updateSettings(userProvider.user);
    status = Status.COMPLETED;
    return status;
  }

  // Update Currency
  ///
  Future<void> updateSettings(
    User user,
  ) async {
    final Settings settings = Settings(
      settingsId: settingsProvider.settings.settingsId,
      firstInstall: settingsProvider.settings.firstInstall,
      refreshDate: settingsProvider.settings.refreshDate,
      createdAt: settingsProvider.settings.createdAt,
      updatedAt: DateTime.now(),
      currency: selectedCurrency,
      user: user,
    );
    await _settingsRepository.upsert(settings);

    settingsProvider.settings = settings;
  }


  /// Initialize [_currencyList] data
  ///
  void _initCurrencies() {
    _currencyList = _currencyRepository.currencyList;
    if(settingsProvider != null)
    {
      currency = settingsProvider.settings.currency.name;
    }

    currencyIndex =
        _currencyList.indexWhere((Currency curren) => curren.name == currency);
    if (currencyIndex >= 0) {
      _selectedCurrency = _currencyList[currencyIndex];
    } else {
      _selectedCurrency = _currencyList[0];
    }
  }
}
