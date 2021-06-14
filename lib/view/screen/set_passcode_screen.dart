import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:mybudget/controller/set_passcode_controller.dart';
import 'package:mybudget/routes.dart';
import 'package:mybudget/view/screen/template_screen.dart';
import 'package:mybudget/view/widget/budget_button.dart';
import 'package:mybudget/view/widget/budget_text_field.dart';

class SetPasscodeScreen extends TemplateScreen {
  @override
  Widget get title => const Text('Set Passcode');

  @override
  Widget getLeading(BuildContext context) => IconButton(
      onPressed: () {
        final SetPasscodeController controller = Get.find();
        controller.reset();
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back_ios_rounded));

  @override
  Widget buildBody(BuildContext context) {
    final SetPasscodeController controller = Get.put(SetPasscodeController());

    return GetBuilder<SetPasscodeController>(
      init: controller,
      builder: (_) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(40, 5, 40, 80),
            child: Column(
              children: <Widget>[
                _switch(controller),
                _pinContainer(controller),
                _recoveryEmailContainer(controller),
                const SizedBox(height: 40),
                BudgetButton(() {
                  Routes.pushNamed(Routes.SCREEN_SIGN_IN);
                }, 'Save'),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Switch widget
  ///
  ///
  Widget _switch(SetPasscodeController controller) => Row(
        children: <Widget>[
          Switch(
              activeTrackColor: Colors.black,
              activeColor: Colors.white,
              value: controller.isEnabled,
              onChanged: (bool val) {
                controller.isEnabled = val;
              }),
          Text(
            controller.isEnabled ? 'Enabled' : 'Disabled',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );

  Widget _pinContainer(SetPasscodeController controller) => Column(
        children: <Widget>[
          _pin(
            label: 'Current Pin',
            isShow: controller.isShowCurrentPin,
            onShow: (bool val) => controller.isShowCurrentPin = val,
            validation: controller.currentPinValidation,
            onChange: controller.currentPinOnChange,
          ),
          _pin(
              label: 'New Pin',
              isShow: controller.isShowNewPin,
              onShow: (bool val) => controller.isShowNewPin = val,
              validation: controller.newPinValidation,
              onChange: controller.newPinOnChange),
          _pin(
              label: 'Verify',
              isShow: controller.isShowVerifyPin,
              onShow: (bool val) => controller.isShowVerifyPin = val,
              validation: controller.verifyPinValidation,
              onChange: controller.verifyPinOnChange,
              enabled: controller.newPinValue.length == 4),
          const SizedBox(height: 20),
          const Text(
            'Set-up passcode for this device',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );

  Widget _recoveryEmailContainer(SetPasscodeController controller) => Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(width: 5),
                Expanded(
                    child: BudgetTextField(
                  controller: controller.emailRecoveryController,
                )),
              ],
            ),
            const SizedBox(height: 5),
            const Text(
              'Recovery email',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Set Recovery email in case of forgotten passcode',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );

  /// Pin Widget
  ///
  ///
  Widget _pin({
    @required String label,
    @required bool isShow,
    @required Function(bool) onShow,
    @required PinValidation validation,
    @required Function(String) onChange,
    bool enabled,
  }) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
              if (validation == PinValidation.success)
                const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
              if (validation == PinValidation.error)
                const Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                ),
              if (validation == PinValidation.nutral) const SizedBox(width: 20),
              Container(
                alignment: Alignment.center,
                width: 100,
                child: PinCodeFields(
                    enabled: enabled ?? true,
                    autoHideKeyboard: false,
                    keyboardType: TextInputType.number,
                    activeBorderColor: Colors.black,
                    borderColor:
                        (enabled ?? true) ? Colors.purple : Colors.grey,
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    obscureCharacter: 'O',
                    obscureText: !isShow,
                    onChange: onChange),
              ),
              InkWell(
                  onTap: () => onShow(!isShow),
                  child: Text(
                    !isShow ? 'SHOW' : 'HIDE',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ))
            ],
          ),
          Text(label,
              style: const TextStyle(
                color: Colors.grey,
              )),
        ],
      );
}
