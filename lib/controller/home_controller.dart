import 'dart:collection';

import 'package:mybudget/controller/base_controller.dart';
import 'package:mybudget/enum/status.dart';
import 'package:mybudget/model/monthly_summary.dart';
import 'package:mybudget/repository/monthly_repository.dart';

class HomeController extends BaseController {
  final MonthlySummaryRepository _monthlySummaryRepository =
      MonthlySummaryRepository();

  List<MonthlySummary> _monthlyBudgetList = <MonthlySummary>[];

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
    await _monthlySummaryRepository.updateMonthlySummary();
    _monthlyBudgetList =
    await _monthlySummaryRepository.getMonthlySummaryList();
    status = Status.COMPLETED;
  }

  /// Update current monthly budget list
  ///
  ///
  Future<void> updateCurrentMonthlyBudgetList() async {
    await _monthlySummaryRepository.updateMonthlySummary();
    final MonthlySummary monthlySummary =
        await _monthlySummaryRepository.currentMonthlySummary();
    _monthlyBudgetList[0] = monthlySummary;
    update();
  }

  String getCurrency() => settingsProvider.settings.currency.name;
}
