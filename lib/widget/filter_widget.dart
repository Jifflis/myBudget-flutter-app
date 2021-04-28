import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mybudget/constant/custom_colors.dart';

class FilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(FilterController());
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<FilterController>(
        builder: (FilterController controller) {
          return SearchField(controller);
        },
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField(this.controller);

  final FilterController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: .5,
            blurRadius: 4,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: ListView(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          ..._buildListOfFilters(),
          const SizedBox(
            width: 8,
          ),
          _buildTextField(),
        ],
      ),
    );
  }

  List<Widget> _buildListOfFilters() {
    return controller.filters
        .map(
          (Filter e) => FilterCard(
            e,
            onRemove: controller.removeFilter,
          ),
        )
        .toList();
  }

  Widget _buildTextField() {
    return Container(
      width: 70,
      child: TextField(
        onChanged: controller.onTextChange,
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}

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
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () =>onRemove(filter),
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



enum FilterType {
  month,
  day,
  year,
  account,
  remarks,
}

class Filter {
  Filter(this.name, this.type);

  final String name;
  final FilterType type;
}

class FilterController extends GetxController {
  List<Filter> filters = <Filter>[];

  void _addDefaultFilter() {
    final DateTime dateNow = DateTime.now();
    filters = <Filter>[
      Filter(DateFormat.MMMM().format(dateNow), FilterType.month),
      Filter(dateNow.day.toString(), FilterType.day),
      Filter(dateNow.year.toString(), FilterType.year),
    ];
  }

  @override
  void onInit() {
    _addDefaultFilter();
    super.onInit();
  }

  void removeFilter(Filter filter) {
    filters.remove(filter);
    update();
  }

  void onTextChange(String text) {
    print(text);
  }


}
