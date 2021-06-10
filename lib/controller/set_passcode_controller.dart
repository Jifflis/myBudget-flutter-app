import 'package:flutter/cupertino.dart';
import 'package:mybudget/controller/base_controller.dart';

enum PinValidation {
  nutral,
  error,
  success,
}

class SetPasscodeController extends BaseController {
  bool _isEnabled = false;

  bool _isShowCurrentPin = false;
  bool _isShowNewPin = false;
  bool _isShowVerifyPin = false;

  PinValidation _currentPinValidation = PinValidation.nutral;
  PinValidation _newPinValidation = PinValidation.nutral;
  PinValidation _verifyPinValidation = PinValidation.nutral;

  final TextEditingController currentPinController = TextEditingController();
  final TextEditingController newPinController = TextEditingController();
  final TextEditingController verifyPinController = TextEditingController();

  final TextEditingController emailRecoveryController = TextEditingController();

  /// get data [_currentPinValidation]
  ///
  ///
  PinValidation get currentPinValidation => _currentPinValidation;

  /// set data [_currentPinValidation]
  ///
  ///
  set currentPinValidation(PinValidation val) {
    _currentPinValidation = val;
    update();
  }

  /// get data [_newPinValidation]
  ///
  ///
  PinValidation get newPinValidation => _newPinValidation;

  /// set data [_newPinValidation]
  ///
  ///
  set newPinValidation(PinValidation val) {
    _newPinValidation = val;
    update();
  }

  /// get data [_verifyPinValidation]
  ///
  ///
  PinValidation get verifyPinValidation => _verifyPinValidation;

  /// set data [_verifyPinValidation]
  ///
  ///
  set verifyPinValidation(PinValidation val) {
    _verifyPinValidation = val;
    update();
  }

  /// currentPin OnChange
  ///
  ///
  void currentPinOnChange(String value) {
    if (currentPinController.text.length < 4) {
      currentPinValidation = PinValidation.nutral;
    } else {
      currentPinValidation = PinValidation.success;
    }
    update();
  }

  /// newPin OnChange
  ///
  ///
  void newPinOnChange(String value) {
    if (newPinController.text.length < 4) {
      newPinValidation = PinValidation.nutral;
    } else {
      newPinValidation = PinValidation.success;
    }

    verifyPinOnChange(null);
    update();
  }

  /// verifyPin OnChange
  ///
  ///
  void verifyPinOnChange(String value) {
    if (newPinController.text.length < 4 ||
        verifyPinController.text.length < 4) {
      verifyPinValidation = PinValidation.nutral;
    }

    if (newPinController.text == verifyPinController.text &&
        newPinController.text.length == 4 &&
        verifyPinController.text.length == 4) {
      verifyPinValidation = PinValidation.success;
    } else if (newPinController.text != verifyPinController.text &&
        newPinController.text.length == 4 &&
        verifyPinController.text.length == 4) {
      verifyPinValidation = PinValidation.error;
    }
    update();
  }

  /// get data [_isEnabled]
  ///
  ///
  bool get isEnabled => _isEnabled;

  /// set data [_isEnabled]
  ///
  ///
  set isEnabled(bool val) {
    _isEnabled = val;
    update();
  }

  /// get data [_isShowCurrentPin]
  ///
  ///
  bool get isShowCurrentPin => _isShowCurrentPin;

  /// set data [_isShowCurrentPin]
  ///
  ///
  set isShowCurrentPin(bool val) {
    _isShowCurrentPin = val;
    update();
  }

  /// get data [_isShowNewPin]
  ///
  ///
  bool get isShowNewPin => _isShowNewPin;

  /// set data [_isShowNewPin]
  ///
  ///
  set isShowNewPin(bool val) {
    _isShowNewPin = val;
    update();
  }

  /// get data [_isShowVerifyPin]
  ///
  ///
  bool get isShowVerifyPin => _isShowVerifyPin;

  /// set data [_isShowVerifyPin]
  ///
  ///
  set isShowVerifyPin(bool val) {
    _isShowVerifyPin = val;
    update();
  }

  bool pinVerifyValidation() {
    // if (newPinController.text.length < 4 ||
    //     verifyPinController.text.length < 4) {
    //   return null;
    // }

    return newPinController.text == verifyPinController.text;
  }

  @override
  void dispose() {
    super.dispose();
    currentPinController.dispose();
    newPinController.dispose();
    verifyPinController.dispose();
    emailRecoveryController.dispose();
  }
}
