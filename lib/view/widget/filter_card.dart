import 'package:flutter/material.dart';
import 'package:mybudget/constant/custom_colors.dart';
import 'package:mybudget/model/filter.dart';

class FilterCard extends StatelessWidget {
  const FilterCard(this.filter, {this.onRemove});

  final Filter filter;
  final Function onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: CustomColors.gray12,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            filter.name,
            style: const TextStyle(color: Colors.black, fontSize: 12),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => onRemove(filter),
            child: const Icon(
              Icons.close,
              size: 14,
              color: CustomColors.gray2,
            ),
          ),
        ],
      ),
    );
  }
}
