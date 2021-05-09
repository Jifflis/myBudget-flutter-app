import '../enum/status.dart';
import '../model/settings.dart';
import '../repository/currency_repository.dart';
import '../repository/settings_repository.dart';
import '../resources/local_db.dart';
import '../routes.dart';
import 'base_controller.dart';

class InitialController extends BaseController {
  SettingsRepository _settingsRepository;
  CurrencyRepository _currencyRepository;

  Settings _settings;

  bool _isFirstLaunch;

  Settings get settings => _settings;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  ///Initialize
  ///
  ///
  Future<void> init() async {
    //set loading status
    status = Status.LOADING;

    //initialize local db
    _isFirstLaunch = await LocalDB.instance().initialize();

    //initialize repositories
    _initRepositories();

    //initialize settings
    _settings = await _settingsRepository.getSettings();

    //initialize first launch data
    await _initFirstLaunchData();

    //set complete status
    status = Status.COMPLETED;

    //navigate screen destination
    _navigateDestination();
  }

  /// Navigate to screen destination
  /// either [IntroductionScreen] or [MainScreen]
  ///
  void _navigateDestination() {
    if (_settings == null || _settings.firstInstall) {
      Routes.pushReplacementNamed(Routes.SCREEN_INTRODUCTION);
    } else {
      Routes.pushReplacementNamed(Routes.SCREEN_MAIN);
    }
  }

  /// Initialize first launch
  ///
  ///
  Future<void> _initFirstLaunchData() async {
    if (_isFirstLaunch) {
      await _currencyRepository.saveDefaultCurrencies();
    }
  }

  /// Initialize repositories
  ///
  ///
  void _initRepositories() {
    _settingsRepository = SettingsRepository.instance;
    _currencyRepository = CurrencyRepository.instance;
  }
}
