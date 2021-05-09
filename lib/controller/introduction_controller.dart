import 'dart:collection';

import 'package:get/get.dart';
import 'package:mybudget/provider/user_provider.dart';

import '../enum/status.dart';
import '../model/currency.dart';
import '../model/settings.dart';
import '../model/user.dart';
import '../repository/currency_repository.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import '../util/date_util.dart';
import '../util/id_util.dart';
import 'base_controller.dart';

class IntroductionController extends BaseController {
  final CurrencyRepository _currencyRepository = CurrencyRepository();
  final SettingsRepository _settingsRepository = SettingsRepository();

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

  /// Save data into local database
  /// It will create a default user
  ///
  Future<Status> save() async {
    status = Status.LOADING;
    await _saveSettings(userProvider.user);
    status = Status.COMPLETED;
    return status;
  }

  /// Save Settings into local database
  ///
  Future<void> _saveSettings(User user) async {
    final Settings settings = Settings(
      settingsId: randomID(),
      firstInstall: false,
      refreshDate: getLastDateOfMonth(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      currency: _selectedCurrency,
      user: user,
    );
    await _settingsRepository.upsert(settings);
  }
}
