import 'package:get/get.dart';

class MaintenanceDialogController extends GetxController{
  bool dialogVisible = false;

  void toggleDialog() {
    dialogVisible = !dialogVisible;
    update();
  }
}