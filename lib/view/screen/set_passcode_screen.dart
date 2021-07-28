import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:get/get.dart';

import '../../controller/set_passcode_controller.dart';
import '../../enum/pin_validation.dart';
import '../../routes.dart';
import '../widget/budget_button.dart';
import '../widget/budget_text_field.dart';
import 'template_screen.dart';

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

    return GetBuilder<SetPasscodeController>(
      init: SetPasscodeController(),
      builder: (SetPasscodeController controller) {
        switch(controller.screenType){
          case ScreenViewType.enablePassCode:
            return _buildEnableWidget(controller);
          case ScreenViewType.setupPassCode:
            return _buildShowSetupWidget(controller);
          default:
            return _buildFillUpPassCode(controller);
        }
      },
    );
  }

  Widget _buildFillUpPassCode(SetPasscodeController controller) =>
      SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(40, 5, 40, 80),
          child: Column(
            children: <Widget>[
              _buildPinContainer(controller),
              const SizedBox(height: 30),
              _buildRecoveryEmail(controller),
              const SizedBox(height: 40),
              BudgetButton(() {
                Routes.pushNamed(Routes.SCREEN_SIGN_IN);
              }, 'Save'),
            ],
          ),
        ),
      );

  /// Build enable widget
  ///
  Widget _buildEnableWidget(SetPasscodeController controller) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildSwitch(controller),
            const SizedBox(
              height: 14,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Change Passcode'),
            )
          ],
        ),
      );

  /// Build set-up widget
  ///
  Widget _buildShowSetupWidget(SetPasscodeController controller) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                controller.screenType = ScreenViewType.fillUpPasscode;
              },
              child: const Text(
                'Set-up Passcode',
                style: TextStyle(color: Colors.purple),
              ),
            )
          ],
        ),
      );

  /// Switch widget
  ///
  ///
  Widget _buildSwitch(SetPasscodeController controller) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Switch(
              activeTrackColor: Colors.black,
              activeColor: Colors.white,
              value: controller.isEnabled,
              onChanged: (bool val) {
                controller.isEnabled = val;
              }),
          Text(
            controller.isEnabled ? 'Disabled' : 'Enabled',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );

  Widget _buildPinContainer(SetPasscodeController controller) => Container(
        margin: const EdgeInsets.only(top: 8),
        child: Column(
          children: <Widget>[
            if(controller.changePassword)
            _buildPin(
              label: 'Current Pin',
              isShow: controller.isShowCurrentPin,
              onShow: (bool val) => controller.isShowCurrentPin = val,
              validation: controller.currentPinValidation,
              onChange: controller.currentPinOnChange,
            ),
            _buildPin(
                label: 'New Pin',
                isShow: controller.isShowNewPin,
                onShow: (bool val) => controller.isShowNewPin = val,
                validation: controller.newPinValidation,
                onChange: controller.newPinOnChange),
            _buildPin(
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
        ),
      );

  Widget _buildRecoveryEmail(SetPasscodeController controller) => Container(
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
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
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
  Widget _buildPin({
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
              const SizedBox(
                width: 16,
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: const Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                alignment: Alignment.center,
                width: 100,
                child: PinCodeFields(
                    enabled: enabled ?? true,
                    autoHideKeyboard: false,
                    keyboardType: TextInputType.number,
                    activeBorderColor: Colors.purple,
                    borderColor:
                        (enabled ?? true) ? Colors.purple[300] : Colors.grey,
                    borderWidth: 1,
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      color: Colors.purple,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    obscureCharacter: '*',
                    obscureText: !isShow,
                    onChange: onChange),
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: InkWell(
                  onTap: () => onShow(!isShow),
                  child: Text(
                    !isShow ? 'SHOW' : 'HIDE',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      );
}
