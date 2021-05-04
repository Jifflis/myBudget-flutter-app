import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class ViewBudgetController extends GetxController {
  final RxBool _isFieldEnabled = false.obs;

  set isEnabled(bool isEnabled) {
    _isFieldEnabled.value = isEnabled;
    update();
  }

  bool get isEnabled => _isFieldEnabled.value;
}
