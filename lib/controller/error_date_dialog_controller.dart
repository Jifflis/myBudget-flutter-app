import 'package:get/get.dart';

class ErrorDateDialogController extends GetxController{
  bool dialogVisible = false;

  void toggleDialog() {
    dialogVisible = !dialogVisible;
    update();
  }
}