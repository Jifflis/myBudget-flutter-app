import 'package:flutter/material.dart';

class BudgetDateSelectorButton extends StatelessWidget {
  const BudgetDateSelectorButton({
    Key key,
    @required this.selectedDate,
    @required this.dateCallBack,
    this.enabled,
  }) : super(key: key);
  final DateTime selectedDate;
  final Function(DateTime) dateCallBack;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 10, right: 10),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
              offset: Offset(0, 3),
            )
          ],
          border: Border.all(
              color: enabled ?? true ? Colors.purple : Colors.grey[400]),
        ),
        child: Text(
          '${selectedDate.month.toString().padLeft(2, "0")}/${selectedDate.day.toString().padLeft(2, "0")}/${selectedDate.year}',
          style: const TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      onTap: enabled ?? true
          ? () async {
              final DateTime dateTime = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(9999),
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
