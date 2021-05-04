import 'dart:collection';

import 'package:mybudget/enum/status.dart';

import '../model/currency.dart';
import '../model/settings.dart';
import '../model/user.dart';
import '../repository/currency_repository.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import '../util/date_util.dart';
import '../util/random_util.dart';
import 'base_controller.dart';

class IntroductionController extends BaseController {
  final CurrencyRepository _currencyRepository = CurrencyRepository.instance;
  final SettingsRepository _settingsRepository = SettingsRepository.instance;
  final UserRepository _userRepository = UserRepository.instance;

  List<Currency> _currencyList = <Currency>[];

  Currency _selectedCurrency;

  @override
  void onInit() {
    _initCurrencies();
    super.onInit();
  }

  UnmodifiableListView<Currency> get currencyList =>
      UnmodifiableListView<Currency>(_currencyList);

  Currency get selectedCurrency => _selectedCurrency;

  set selectedCurrency(Currency currency) {
    _selectedCurrency = currency;
    update();
  }

  void _initCurrencies() {
    _currencyList = _currencyRepository.currencyList;
    _selectedCurrency = _currencyList[0];
  }

  Future<Status> save() async {
    status = Status.LOADING;
    final User user = User.factory();
    await _saveUser(user);
    await _saveSettings(user);
    status = Status.COMPLETED;
    return status;
  }

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

  Future<void> _saveUser(User user) async {
    await _userRepository.upsert(user);
  }
}
