import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../enum/status.dart';
import '../provider/settings_provider.dart';
import '../repository/settings_repository.dart';
import '../util/maintenance_util.dart';
import 'base_controller.dart';

class MainController extends BaseController with WidgetsBindingObserver {
  MainController(this.context) : super(provideSettings: false) {
    WidgetsBinding.instance.addObserver(this);
  }

  BuildContext context;

  final RxInt _selectedBottomIndex = 0.obs;

  StreamController<int> onTabPageChange = StreamController<int>.broadcast();
  SettingsRepository settingsRepository = SettingsRepository();

  @override
  Future<void> didChangeAppLifecycleState(final AppLifecycleState state) async {
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
}
