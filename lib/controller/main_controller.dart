import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../channel/SettingsChannel.dart';
import '../enum/status.dart';
import '../provider/settings_provider.dart';
import '../repository/settings_repository.dart';
import '../routes.dart';
import '../util/maintenance_util.dart';
import '../view/dialog/budget_dialog.dart';
import 'base_controller.dart';
import 'error_date_dialog_controller.dart';

class MainController extends BaseController with WidgetsBindingObserver {
  MainController(this.context, this.settingsRepository,
      {bool useForTest = false})
      : super(provideSettings: false) {
    if (!useForTest)
      WidgetsBinding.instance.addObserver(this);
  }

  BuildContext context;

  final RxInt _selectedBottomIndex = 0.obs;

  StreamController<int> onTabPageChange = StreamController<int>.broadcast();
  SettingsRepository settingsRepository;

  @override
  Future<void> didChangeAppLifecycleState(final AppLifecycleState state) async {
    checkTime();

    if (state == AppLifecycleState.resumed &&
        MaintenanceUtil.isAbleToRequest(DateTime.now())) {
      MaintenanceUtil.showMaintenanceDialog(context);
    }
  }

  @override
  Future<void> onInit() async {
    status = Status.LOADING;
    Get.put(SettingsProvider(await settingsRepository.getSettings()));
    status = Status.COMPLETED;
    checkTime();
    super.onInit();
  }

  set selectedBottomIndex(RxInt index) {
    _selectedBottomIndex.value = index.value;
    onTabPageChange.add(index.value);
  }

  RxInt get selectedBottomIndex => _selectedBottomIndex;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Check if time is network provided.
  /// Then show a dialog if not network provided
  ///
  /// This will work only for android
  ///
  Future<void> checkTime() async {
    if (!Platform.isAndroid) {
      return;
    }

    final int result = await SettingsChannel().isNetworkProvidedTime();
    final ErrorDateDialogController dateDialogController =
        Get.put(ErrorDateDialogController());
    if (dateDialogController.dialogVisible) {
      Routes.pop();
      dateDialogController.toggleDialog();
    }
    if (result == 0) {
      showBudgetDialog(
        barrierDismissible: false,
        context: context,
        title: 'Date Error!',
        description: 'Please use network provided time in settings.',
        button1Title: 'Goto Settings',
        showButton2: false,
        showButton1: true,
        onButton1Press: () {
          SettingsChannel().gotoToDateSettings();
        },
      );
      dateDialogController.toggleDialog();
    }
  }
}
