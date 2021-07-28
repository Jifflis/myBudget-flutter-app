import 'package:flutter/cupertino.dart';

import '../enum/pin_validation.dart';
import 'base_controller.dart';

enum ScreenViewType{
  setupPassCode,
  enablePassCode,
  fillUpPasscode,
}

class SetPasscodeController extends BaseController {
  bool _isEnabled = false;

  bool _isShowCurrentPin = false;
  bool _isShowNewPin = false;
  bool _isShowVerifyPin = false;

  ScreenViewType _screenType = ScreenViewType.setupPassCode;

  bool changePassword = false;

  PinValidation _currentPinValidation = PinValidation.nutral;
  PinValidation _newPinValidation = PinValidation.nutral;
  PinValidation _verifyPinValidation = PinValidation.nutral;

  String _currentPinValue = '';
  String _newPinValue = '';
  String _verifyPinValue = '';

  TextEditingController emailRecoveryController;

  ScreenViewType get screenType=>_screenType;

  /// Set screen Type
  ///
  set screenType(ScreenViewType type){
    _screenType = type;
    update();
  }

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
    _currentPinValue = value;
    _validationChecker();
    update();
  }

  /// newPin OnChange
  ///
  ///
  void newPinOnChange(String value) {
    _newPinValue = value;
    _validationChecker();
    update();
  }

  /// verifyPin OnChange
  ///
  ///
  void verifyPinOnChange(String value) {
    _verifyPinValue = value;
    _validationChecker();
    update();
  }

  /// get data [_newPinValue]
  ///
  ///
  String get newPinValue => _newPinValue;

  /// validation checker
  ///
  ///
  void _validationChecker() {
    ///! currentPin
    if (_currentPinValue.length < 4) {
      currentPinValidation = PinValidation.nutral;
    } else {
      currentPinValidation = PinValidation.success;
    }

    ///! verifyPin
    if (_newPinValue.length < 4 || _verifyPinValue.length < 4) {
      verifyPinValidation = PinValidation.nutral;
    }

    if (_newPinValue == _verifyPinValue &&
        _newPinValue.length == 4 &&
        _verifyPinValue.length == 4) {
      verifyPinValidation = PinValidation.success;
    } else if (_newPinValue != _verifyPinValue &&
        _newPinValue.length == 4 &&
        _verifyPinValue.length == 4) {
      verifyPinValidation = PinValidation.error;
    }

    ///! newPin
    if (_newPinValue.length < 4) {
      newPinValidation = PinValidation.nutral;
    } else {
      newPinValidation = PinValidation.success;
    }
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

  @override
  void onInit() {
    emailRecoveryController = TextEditingController();
    print('on init gyud');
    super.onInit();

  }

  @override
  void dispose() {
    print('is dipsosed');
    emailRecoveryController.dispose();
    super.dispose();

  }

  void reset() {
    _isEnabled = false;

    _isShowCurrentPin = false;
    _isShowNewPin = false;
    _isShowVerifyPin = false;

    _currentPinValidation = PinValidation.nutral;
    _newPinValidation = PinValidation.nutral;
    _verifyPinValidation = PinValidation.nutral;

    _currentPinValue = '';
    _newPinValue = '';
    _verifyPinValue = '';

    emailRecoveryController.clear();
  }
}
