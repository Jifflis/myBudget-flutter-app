import 'package:mybudget/controller/currency_controller.dart';
import 'package:mybudget/provider/settings_provider.dart';
import 'package:mybudget/provider/user_provider.dart';
import 'package:get/get.dart';

class ChangeCurrencyController extends CurrencyController {
     ChangeCurrencyController({
    this.provideSettings = true,
      this.provideUser = true,
  });
  @override
  // ignore: overridden_fields
  bool provideSettings;
   bool provideUser;
  
  @override
  // ignore: overridden_fields
  SettingsProvider settingsProvider;
  @override
  // ignore: overridden_fields
  UserProvider userProvider;

    @override
  void onInit() {

    if (provideSettings) {
      settingsProvider = Get.find();
    }

     if (provideUser) {
      userProvider = Get.find();
    }
    super.onInit();
  }
}
