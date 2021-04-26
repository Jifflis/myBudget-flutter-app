import 'package:get/get.dart';

class BaseController extends GetxController {
  Status _status;

  set status(Status status) {
    _status = status;
    update();
  }

  Status get status => _status;

  set message(String message) {
    update();
  }
}

enum Status { LOADING, COMPLETED, ERROR }
