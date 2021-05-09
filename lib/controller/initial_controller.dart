import 'package:get/get.dart';

import '../enum/status.dart';
import '../model/monthly_summary.dart';
import '../model/settings.dart';
import '../model/user.dart';
import '../provider/user_provider.dart';
import '../repository/monthly_repository.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import '../resources/local_db.dart';
import '../routes.dart';
import '../util/id_util.dart';
import 'base_controller.dart';

class InitialController extends BaseController {
  InitialController() : super(initializeUser: false);

  SettingsRepository _settingsRepository;
  UserRepository _userRepository;
  MonthlySummaryRepository _monthlyRepository;

  Settings _settings;

  bool _isFirstLaunch;

  Settings get settings => _settings;

  User user;

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
    _isFirstLaunch = await LocalDB().initialize();

    //initialize repositories
    _initRepositories();

    //initialize user
    await _initUser();

    //initialize monthly summary
    await _initMonthlySummary();

    //initialize settings
    _settings = await _settingsRepository.getSettings();

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

  /// Initialize repositories
  ///
  ///
  void _initRepositories() {
    _settingsRepository = SettingsRepository();
    _userRepository = UserRepository();
    _monthlyRepository = MonthlySummaryRepository();
  }

  /// Initialize user
  ///
  Future<void> _initUser() async {
    if (_isFirstLaunch) {
      user = User.factory();
      await _userRepository.upsert(user);
    } else {
      user = await _userRepository.getUser();
    }
    Get.put(UserProvider(user));
  }

  /// Initialize monthly summary
  ///
  Future<void> _initMonthlySummary() async {
    final MonthlySummary summary = await _monthlyRepository.currentMonthlySummary();
    print(summary);

    if (summary == null) {
      _monthlyRepository.upsert(MonthlySummary(
        monthlySummaryId: monthlySummaryID(),
        month: DateTime.now().month,
        year: DateTime.now().year,
        user: user,
      ));
    }
  }
}
