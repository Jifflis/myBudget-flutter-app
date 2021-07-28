import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:mybudget/util/id_util.dart';

import '../enum/status.dart';
import '../model/monthly_summary.dart';
import '../repository/monthly_repository.dart';
import 'base_controller.dart';

class HomeController extends BaseController {
  final MonthlySummaryRepository _monthlySummaryRepository =
      MonthlySummaryRepository();

  List<MonthlySummary> _monthlyBudgetList = <MonthlySummary>[];
  PageController pageController = PageController();

  @override
  void onInit() {
    //set loading status
    _initMonthlySummaryList();
    super.onInit();
  }

  /// get unmodifiable [_monthlyBudgetList]
  ///
  ///
  UnmodifiableListView<MonthlySummary> get monthlyBudgetList =>
      UnmodifiableListView<MonthlySummary>(_monthlyBudgetList);

  /// Initialize [_monthlyBudgetList] data
  ///
  ///
  Future<void> _initMonthlySummaryList() async {
    status = Status.LOADING;
    await _monthlySummaryRepository.updateMonthlySummary(monthlySummaryID());
    _monthlyBudgetList =
        await _monthlySummaryRepository.getMonthlySummaryList();
    status = Status.COMPLETED;
  }

  /// Update current monthly budget list
  ///
  ///
  Future<void> updateCurrentMonthlyBudgetList() async {
    await _monthlySummaryRepository.updateMonthlySummary(monthlySummaryID());
    final MonthlySummary monthlySummary =
        await _monthlySummaryRepository.currentMonthlySummary();
    _monthlyBudgetList[0] = monthlySummary;
    update();
  }

  String getCurrency() => settingsProvider.settings.currency.name;
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
