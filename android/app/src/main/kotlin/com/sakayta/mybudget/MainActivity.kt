package com.sakayta.mybudget

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}
import 'package:flutter/material.dart';

class BudgetDateSelectorButton extends StatelessWidget {
    const BudgetDateSelectorButton({
        Key key,
        @required this.selectedDate,
        @required this.dateCallBack,
        @required this.text,
        this.enabled,
        this.fontSize = 16,
    }) : super(key: key);
    final DateTime selectedDate;
    final Function(DateTime) dateCallBack;
    final bool enabled;
    final String text;
    final double fontSize;

    @override
    Widget build(BuildContext context) {
        return InkWell(
                child: Container(
                child: Text(
                text,
                style: TextStyle(
                fontSize: fontSize,
        ),
        ),
        ),
        onTap: enabled ?? true
        ? () async {
        final DateTime dateTime = await showDatePicker(
                context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget child) {
        return Theme(
                data: Theme.of(context).copyWith(
                colorScheme: ColorScheme(
                primary: Colors.purple[800],
        primaryVariant: Colors.purple[800],
        secondary: Colors.purple[800],
        secondaryVariant: Colors.purple[800],
        surface: Colors.purple[800],
        background: Colors.purple[800],
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.purple[800],
        onSurface: Colors.purple[800],
        onBackground: Colors.purple[800],
        onError: Colors.red,
        brightness: Brightness.light,
        )),
        child: child,
        );
    });
        if (dateTime != null) {
            dateCallBack(dateTime);
        }
    }
        : null,
        );
    }
}
