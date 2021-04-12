import 'package:flutter_test/flutter_test.dart';
import 'package:mybudget/controller/main_controller.dart';

void main() {
  test('set/get bottom index', () {
    MainController controller = MainController();
    int testValue = 1;
    controller.selectedBottomIndex.value = testValue;
    expect(controller.selectedBottomIndex.value, testValue);
  });
}
