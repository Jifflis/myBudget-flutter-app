import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

Color balanceColorIndicator({
  @required double budget,
  @required double balance,
}) {
  final double limit = budget * 0.10;
  if (balance < limit && balance > 0) {
    return Colors.amber[700];
  } else if (balance <= 0) {
    return Colors.red;
  } else {
    return Colors.black;
  }
}
