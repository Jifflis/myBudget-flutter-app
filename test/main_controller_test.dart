import 'package:flutter_test/flutter_test.dart';
import 'package:mybudget/controller/main_controller.dart';

void main() {
  test('set/get bottom index', () {
    final MainController controller = MainController();
    const int testValue = 1;
    controller.selectedBottomIndex.value = testValue;
    expect(controller.selectedBottomIndex.value, testValue);
  });
}
