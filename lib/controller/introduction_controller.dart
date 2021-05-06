import 'package:mybudget/controller/currency_controller.dart';

import '../enum/status.dart';
import '../model/settings.dart';
import '../model/user.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import '../util/date_util.dart';
import '../util/random_util.dart';

class IntroductionController extends CurrencyController {
  final SettingsRepository _settingsRepository = SettingsRepository.instance;
  final UserRepository _userRepository = UserRepository.instance;

  /// Save data into local database
  /// It will create a default user
  ///
  Future<Status> save() async {
    status = Status.LOADING;
    final User user = User.factory();
    await _saveUser(user);
    await _saveSettings(user);
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
      currency: selectedCurrency,
      user: user,
    );
    await _settingsRepository.upsert(settings);
  }

  /// Save user into local database
  ///
  Future<void> _saveUser(User user) async {
    await _userRepository.upsert(user);
  }
}
