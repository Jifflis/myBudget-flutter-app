import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../enum/status.dart';
import '../environment.dart';
import '../model/monthly_summary.dart';
import '../model/settings.dart';
import '../model/user.dart';
import '../provider/user_provider.dart';
import '../repository/acount_repository.dart';
import '../repository/monthly_repository.dart';
import '../repository/settings_repository.dart';
import '../repository/transaction_repository.dart';
import '../repository/user_repository.dart';
import '../resources/local_db.dart';
import '../routes.dart';
import '../util/date_util.dart';
import '../util/id_util.dart';
import '../view/screen/introduction_screen.dart';
import '../view/screen/main_screen.dart';
import 'base_controller.dart';

class InitialController extends BaseController {
  InitialController()
      : super(
          initializeUser: false,
          provideSettings: false,
        );

  SettingsRepository _settingsRepository;
  UserRepository _userRepository;
  MonthlySummaryRepository _monthlyRepository;
  AccountRepository _accountRepository;
  TransactionRepository _transactionRepository;

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

    //initialize environment
    await Env.initEnv();

    //initialize local db
    _isFirstLaunch = await LocalDB().initialize();

    //initialize repositories
    _initRepositories();

    //initialize settings
    _settings = await _settingsRepository.getSettings();

    //initialize user
    await _initUser();

    //initialize monthly summary
    await _initMonthlySummary();

    //initialize account refresher
    await _initAccountRefresher();

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
      Routes.rootNavigator.pushReplacement(
        MaterialPageRoute<Widget>(
          builder: (_) => IntroductionScreen(),
        ),
      );
    } else {
      Routes.rootNavigator.pushReplacement(
        MaterialPageRoute<Widget>(
          builder: (_) => MainScreen(),
        ),
      );
    }
  }

  /// Initialize repositories
  ///
  ///
  void _initRepositories() {
    _settingsRepository = SettingsRepository();
    _userRepository = UserRepository();
    _monthlyRepository = MonthlySummaryRepository();
    _accountRepository = AccountRepository();
    _transactionRepository = TransactionRepository();
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
    final MonthlySummary summary =
        await _monthlyRepository.currentMonthlySummary();

    if (summary == null) {
      await _monthlyRepository.upsert(
        MonthlySummary(
          monthlySummaryId: monthlySummaryID(),
          month: DateTime.now().month,
          year: DateTime.now().year,
          userId: user.userId,
        ),
      );
    }
  }

  Future<void> _initAccountRefresher() async {
    if (settings == null || settings.refreshDate == null) {
      return;
    }

    while (resetTime(DateTime.now()).isAfter(settings.refreshDate)) {
      final DateTime newRefreshDate =
          getNextMonthLastDate(settings.refreshDate);

      //update account table
      await _accountRepository.monthlyRefresh(
        monthlySummaryID(date: settings.refreshDate),
        monthlySummaryID(date: newRefreshDate),
        user,
        _transactionRepository,
      );

      //update monthly summary table
      await _monthlyRepository.upsert(
        MonthlySummary(
          monthlySummaryId: monthlySummaryID(date: newRefreshDate),
          month: newRefreshDate.month,
          year: newRefreshDate.year,
          userId: user.userId,
        ),
      );
      await _monthlyRepository.updateMonthlySummary();

      //update settings refresh date
      settings.refreshDate = newRefreshDate;
      await _settingsRepository.upsert(settings);
    }
  }
}
