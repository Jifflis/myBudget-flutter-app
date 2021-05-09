import 'package:get/get.dart';
import 'package:mybudget/provider/user_provider.dart';

import '../enum/status.dart';

abstract class BaseController extends GetxController {
  BaseController({this.initializeUser = true});

  bool initializeUser;
  Status _status = Status.COMPLETED;
  UserProvider userProvider;

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
    if(initializeUser){
      userProvider = Get.find();
    }
    super.onInit();
  }
}
