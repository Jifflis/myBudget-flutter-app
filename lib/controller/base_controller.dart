import 'package:get/get.dart';

import '../enum/status.dart';
import '../provider/settings_provider.dart';
import '../provider/user_provider.dart';

abstract class BaseController extends GetxController {
  BaseController({
    this.initializeUser = true,
    this.provideSettings = true,
  });

  bool initializeUser;
  bool provideSettings;
  Status _status = Status.COMPLETED;
  UserProvider userProvider;
  SettingsProvider settingsProvider;

  set status(Status status) {
    _status = status;
    update();
  }

  Status get status => _status;

  set message(String message) {
    update();
  }

  @override
  void onInit() {
    if (initializeUser) {
      userProvider = Get.find();
    }

    if (provideSettings) {
      settingsProvider = Get.find();
    }
    super.onInit();
  }
}
