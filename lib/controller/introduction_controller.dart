import '../enum/status.dart';
import '../model/settings.dart';
import '../model/user.dart';
import '../repository/settings_repository.dart';
import '../util/date_util.dart';
import '../util/id_util.dart';
import 'currency_controller.dart';

class IntroductionController extends CurrencyController {
  final SettingsRepository _settingsRepository = SettingsRepository();

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
      currency: selectedCurrency,
      user: user,
    );
    await _settingsRepository.upsert(settings);
  }
}
