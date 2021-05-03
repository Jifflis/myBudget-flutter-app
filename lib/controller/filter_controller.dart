import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../enum/filter_type.dart';
import '../model/filter.dart';
import '../util/filter_suggestions.dart';

class FilterController extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<Filter> filters = <Filter>[];
  List<Filter> filterSuggestions = <Filter>[];

  /// Initialize default filter
  ///
  ///
  @override
  void onInit() {
    _addDefaultFilter();
    super.onInit();
  }

  /// Add default filters
  /// default filters are
  /// [FilterType.month],[FilterType.day],[FilterType.year]
  ///
  void _addDefaultFilter() {
    final DateTime dateNow = DateTime.now();
    filters = <Filter>[
      Filter(dateNow.day.toString(), FilterType.day),
      Filter(DateFormat.MMMM().format(dateNow), FilterType.month),
      Filter(dateNow.year.toString(), FilterType.year),
    ];
    filters.sort();
  }

  /// Remove filter in [filters]
  /// it will update all listeners of this controller
  ///
  void removeFilter(Filter filter) {
    filters.remove(filter);
    update();
  }

  /// Add filter in [filters]
  /// filters will be sorted according to order.
  /// Refer [Filter] for the ordering
  /// it will update all listeners of this controller
  ///
  void addFilter(Filter filter) {
    filters.add(filter);
    filters.sort();
    filterSuggestions.clear();
    searchController.clear();
    update();
  }

  /// [searchController] on text change
  ///
  ///
  void onTextChange(String text) {
    _getFilterSuggestions(text);
  }

  /// It will set the [filterSuggestions] according to keyword
  /// If [FilterType] is already in [filters] it will
  /// not return a suggestion for that [FilterType]
  ///
  Future<void> _getFilterSuggestions(String keyword) async {
    final List<Filter> filterSuggestions = <Filter>[];
    if (!isFilterTypeExist(FilterType.month)) {
      filterSuggestions.addAll(searchFilters<Month>(keyword));
    }
    if (!isFilterTypeExist(FilterType.day)) {
      filterSuggestions.addAll(searchFilters<Day>(keyword));
    }
    if (!isFilterTypeExist(FilterType.year)) {
      filterSuggestions.addAll(searchFilters<Year>(keyword));
    }
    if (!isFilterTypeExist(FilterType.account)) {}
    if (!isFilterTypeExist(FilterType.remarks)) {}
    this.filterSuggestions = filterSuggestions;
    update();
  }

  /// Check if [FilterType] is already
  /// exist in [filters]
  /// If exist return true otherwise false
  ///
  bool isFilterTypeExist(FilterType type) {
    for (final Filter filter in filters) {
      if (filter.type == type) {
        return true;
      }
    }
    return false;
  }
}
