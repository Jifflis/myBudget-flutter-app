import 'package:flutter/material.dart';

import '../../model/account.dart';

class AddTransactionDropdown<T> extends StatelessWidget {
  const AddTransactionDropdown({
    @required this.onChange,
    @required this.list,
    @required this.selected,
  });

  final Function(T) onChange;
  final List<T> list;
  final T selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: Colors.purple,
            width: 2,
          )),
      child: Container(
        // margin: EdgeInsets.all(40),
        padding: const EdgeInsets.only(left: 15, right: 15),
        width: double.infinity,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: selected,
            onChanged: onChange,
            items: list
                .map(
                  (T item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      getTitle(item) ?? 'No data',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  String getTitle(T item) {
    if (item is Account) {
      return item.title;
    }
    return null;
  }
}
