import 'dart:async';

import 'package:get/get.dart';

import 'base_controller.dart';

class MainController extends BaseController{
  final RxInt _selectedBottomIndex = 0.obs;

  StreamController<int> onTabPageChange = StreamController<int>.broadcast();

  set selectedBottomIndex(RxInt index){
    _selectedBottomIndex.value =  index.value;
    onTabPageChange.add(index.value);
  }

  RxInt get selectedBottomIndex =>_selectedBottomIndex;

}