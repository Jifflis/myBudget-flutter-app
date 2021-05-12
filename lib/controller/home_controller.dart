import 'package:get/get.dart';
import 'package:mybudget/model/monthly_summary.dart';
import 'package:mybudget/repository/monthly_repository.dart';

class HomeController extends GetxController {
  final MonthlySummaryRepository _monthlySummaryRepository =
      MonthlySummaryRepository();

  final RxBool _isLoading = false.obs;
  List<MonthlySummary> _monthlyBudgetList;

  @override
  void onInit() {
    _initMonthlySummaryList();
    super.onInit();
  }

  /// get monthlyBudgetList
  ///
  List<MonthlySummary> get monthlyBudgetList => _monthlyBudgetList;

  /// set monthlyBudgetList
  ///
  set monthlyBudgetList(List<MonthlySummary> val) {
    _monthlyBudgetList = val;
    update();
  }

  /// get isLoading
  ///
  bool get isLoading => _isLoading.value;

  /// set isLoading
  ///
  set isLoading(bool val) {
    _isLoading.value = val;
    update();
  }

  /// Initialize [_monthlyBudgetList] data
  ///
  Future<void> _initMonthlySummaryList() async {
    isLoading = true;
    monthlyBudgetList = await _monthlySummaryRepository.getMonthlySummaryList();
    isLoading = false;
  }
}
