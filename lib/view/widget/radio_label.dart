import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybudget/constant/custom_colors.dart';

class RadioLabel<T> extends StatelessWidget {
  const RadioLabel({
    Key key,
    @required this.label,
    @required this.value,
    @required this.groupValue,
    @required this.onChange,
    this.gapBetween=0,
    this.alignTop=0,
  }) : super(key: key);

  final String label;
  final T value;
  final T groupValue;
  final Function onChange;
  final double gapBetween;
  final double alignTop;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 0),
    child: Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(35 + gapBetween, 10+alignTop, 0, 0),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Hiragino Kaku Gothic ProN',
              color: CustomColors.gray1,
            ),
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: CustomColors.gray1,
          ),
          child: Radio<T>(
            onChanged: onChange,
            value: value,
            groupValue: groupValue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    ),
  );
}