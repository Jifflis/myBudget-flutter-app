import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../enum/filter_type.dart';
import '../model/filter.dart';
import '../repository/acount_repository.dart';
import '../util/filter_suggestions.dart';

class FilterController extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<Filter> _filters = <Filter>[];
  List<Filter> filterSuggestions = <Filter>[];

  AccountRepository accountRepository = AccountRepository();

  /// Initialize default filter
  ///
  ///
  @override
  void onInit() {
    _addDefaultFilter();
    super.onInit();
  }

  List<Filter> get filters => _filters;

  List<Filter> getFilters() {
    final DateTime dateNow = DateTime.now();
    _filters.sort();

    //check if filter type month is exist
    if (filters.isEmpty || filters[0].type != FilterType.month) {
      _filters.add(
        Filter(
          DateFormat.MMMM().format(dateNow),
          FilterType.month,
          key: dateNow.month.toString(),
        ),
      );
    }

    //check if filter type year is exist
    final Filter filter = filters.firstWhere(
        (Filter element) => element.type == FilterType.year,
        orElse: () => null);
    if (filter == null) {
      _filters.add(
        Filter(dateNow.year.toString(), FilterType.year),
      );
    }

    return _filters;
  }

  /// Add default filters
  /// default filters are
  /// [FilterType.month],[FilterType.day],[FilterType.year]
  ///
  void _addDefaultFilter() {
    _filters = Filter.defaultFilter();
    _filters.sort();
  }

  /// Remove filter in [filters]
  /// it will update all listeners of this controller
  ///
  void removeFilter(Filter filter) {
    _filters.remove(filter);
    update();
  }

  /// Add filter in [filters]
  /// filters will be sorted according to order.
  /// Refer [Filter] for the ordering
  /// it will update all listeners of this controller
  ///
  void addFilter(Filter filter) {
    _filters.add(filter);
    _filters.sort();
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
    if (!isFilterTypeExist(FilterType.account)) {
      // filterSuggestions.addAll(await getTransactionFilter(keyword));
    }
    this.filterSuggestions = filterSuggestions;
    update();
  }

  /// Check if [FilterType] is already
  /// exist in [filters]
  /// If exist return true otherwise false
  ///
  bool isFilterTypeExist(FilterType type) {
    for (final Filter filter in _filters) {
      if (filter.type == type) {
        return true;
      }
    }
    return false;
  }
}
