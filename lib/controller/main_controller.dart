import 'dart:async';

import 'package:get/get.dart';

import '../enum/status.dart';
import '../provider/settings_provider.dart';
import '../repository/settings_repository.dart';
import 'base_controller.dart';

class MainController extends BaseController {
  MainController() : super(provideSettings: false);
  final RxInt _selectedBottomIndex = 0.obs;

  StreamController<int> onTabPageChange = StreamController<int>.broadcast();
  SettingsRepository settingsRepository = SettingsRepository();

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
}
