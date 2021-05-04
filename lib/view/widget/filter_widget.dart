import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/custom_colors.dart';
import '../../controller/filter_controller.dart';
import '../../model/filter.dart';
import '../../routes.dart';
import 'budget_button.dart';
import 'filter_card.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget(this.onOk);

  final Function onOk;

  @override
  Widget build(BuildContext context) {
    Get.put(FilterController());
    return GetBuilder<FilterController>(
      builder: (FilterController controller) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 17),
          margin: const EdgeInsets.symmetric(vertical: 17, horizontal: 17),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildSuggestionList(controller),
              _buildSearchField(controller),
              BudgetButton(onOk, 'Ok'),
            ],
          ),
        );
      },
    );
  }

  /// Build suggestion list
  ///
  ///
  Widget _buildSuggestionList(FilterController controller) => Container(
        height: 150,
        padding: const EdgeInsets.only(left: 17, right: 17, bottom: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: controller.filterSuggestions.isEmpty
            ? _buildNoSuggestion()
            : _buildSuggestions(controller),
      );

  ///build suggestions
  ///
  ///
  ListView _buildSuggestions(FilterController controller) => ListView(
        children: <Widget>[
          ...controller.filterSuggestions
              .map(
                (Filter filter) => InkWell(
                  onTap: () => controller.addFilter(filter),
                  child: Container(
                    color: controller.filterSuggestions.indexOf(filter) == 0
                        ? CustomColors.gray12
                        : null,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Text(
                      filter.name,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              )
              .toList()
        ],
      );

  /// Build no suggestions text
  ///
  ///
  Widget _buildNoSuggestion() => const Center(
        child: Text(
          'No suggestions',
          style: TextStyle(color: CustomColors.gray3),
        ),
      );

  /// Build search field
  ///
  ///
  Widget _buildSearchField(FilterController controller) => Container(
        height: 45,
        margin: const EdgeInsets.only(top: 8, bottom: 30),
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
            ..._buildListOfFilters(controller),
            const SizedBox(width: 8),
            _buildTextField(controller),
          ],
        ),
      );

  ///build list of filters
  ///
  ///
  List<Widget> _buildListOfFilters(FilterController controller) =>
      controller.filters
          .map(
            (Filter e) => FilterCard(
              e,
              onRemove: controller.removeFilter,
            ),
          )
          .toList();

  ///build text field
  ///
  ///
  Widget _buildTextField(FilterController controller) => Container(
        width: 70,
        child: TextField(
          onChanged: controller.onTextChange,
          decoration: const InputDecoration(border: InputBorder.none),
        ),
      );
}
