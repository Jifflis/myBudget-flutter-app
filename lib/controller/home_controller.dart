import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mybudget/controller/base_controller.dart';
import 'package:mybudget/enum/status.dart';
import 'package:mybudget/model/account.dart';
import 'package:mybudget/model/monthly_summary.dart';
import 'package:mybudget/repository/monthly_repository.dart';


class HomeController extends BaseController {
  final MethodChannel _platform = const MethodChannel('com.sakayta.mybudget/image');

  final MonthlySummaryRepository _monthlySummaryRepository =
      MonthlySummaryRepository();

  final Map<String,Image> _accountImageFileList = <String,Image>{};

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

  /// get [_accountImageFileList]
  /// 
  /// 
  Map<String,dynamic> get accountImageFileList => _accountImageFileList;

  /// update [_accountImageFileList]
  /// 
  ///
  void updateImageFile(String name, String path){
    if(path != null){
      final File imageFile = File(path);
      final Image image = Image.file(imageFile, width: 60,height: 60,);
      _accountImageFileList[name.replaceAll(RegExp(' '), '_')] = image;
      update();
    }
  }

  /// Initialize [_monthlyBudgetList] data
  ///
  ///
  Future<void> _initMonthlySummaryList() async {
    status = Status.LOADING;
    await _monthlySummaryRepository.updateMonthlySummary();
    _monthlyBudgetList =
    await _monthlySummaryRepository.getMonthlySummaryList();
    initializeImageList(monthlyBudgetList);
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

  /// get currency
  /// 
  /// 
  String getCurrency() => settingsProvider.settings.currency.name;


  /// initialize account image list
  /// 
  /// 
  Future<void> initializeImageList(List<MonthlySummary> monthlyBudgetList) async {
     final List<Account> accountList = <Account>[];
     for(final MonthlySummary monthlySummary in monthlyBudgetList){
       accountList.addAll(monthlySummary.accountList);
     }

     for(final Account account in accountList){
      final File imageFile = await getImageFile(account.title);
      final Image image = Image.file(imageFile, width: 60,height: 60,);
        _accountImageFileList[account.title.replaceAll(RegExp(' '), '_')] = image;
     }
  }

  /// get image file
  /// 
  /// 
  Future<File> getImageFile(String name) async {
    final String imagePath = await _platform.invokeMethod(
      'getPath',
      <dynamic, String>{
        'name':'img_$name',
      }
    );

    if(imagePath != null){
      return File(imagePath);
    }

    return null;
  }
}
