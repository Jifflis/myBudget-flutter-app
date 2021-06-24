import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[600],
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 150),
              //pin
              _pin(onComplete: (String value) {
                //
              }),
              const SizedBox(height: 20),
              //label
              _label(),
              const SizedBox(height: 20),
              //reset
              _reset(onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  /// Reset
  ///
  ///
  Widget _reset({@required Function onPressed}) => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Forgot passcode?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: onPressed,
              child: const Text(
                'RESET',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );

  /// Label
  ///
  ///
  Widget _label() => Container(
        child: const Text(
          'Sign in with passcode',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 25,
          ),
        ),
      );

  /// Pin Widget
  ///
  ///
  Widget _pin({@required Function(String) onComplete}) => Container(
        alignment: Alignment.center,
        width: 100,
        child: PinCodeFields(
          autofocus: true,
          autoHideKeyboard: false,
          keyboardType: TextInputType.number,
          activeBorderColor: Colors.white,
          borderColor: Colors.amber,
          borderWidth: 2.0,
          padding: EdgeInsets.zero,
          textStyle: const TextStyle(
            color: Colors.amber,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          obscureCharacter: 'O',
          obscureText: true,
          onComplete: onComplete,
        ),
      );
}
