import 'package:get/get.dart';

import '../enum/status.dart';

class BaseController extends GetxController {
  Status _status = Status.COMPLETED;

  set status(Status status) {
    _status = status;
    update();
  }

  Status get status => _status;

  set message(String message) {
    update();
  }
}
