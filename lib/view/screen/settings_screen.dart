import 'package:flutter/material.dart';
import 'package:mybudget/routes.dart';
import 'package:mybudget/view/screen/template_screen.dart';

class SettingsScreen extends TemplateScreen {
  @override
  Widget get title => const Text('Settings');

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _button('Change refresh date', () {}),
          const SizedBox(height: 20),
          _button('Change currency',
              () => Routes.pushNamed(Routes.SCREEN_CHANGE_CURRENCY)),
          const SizedBox(height: 20),
          _button('Set Passcode',
              () => Routes.pushNamed(Routes.SCREEN_SET_PASSCODE)),
        ],
      ),
    );
  }

  /// button
  ///
  ///
  Widget _button(String label, Function onPressed) => ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.purple[800]),
        padding:
            MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white,
          )
        ],
      ));
}
