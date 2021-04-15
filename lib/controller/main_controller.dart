import 'dart:async';

import 'package:get/get.dart';

class MainController extends GetxController{
  final RxInt _selectedBottomIndex = 0.obs;

  StreamController<int> onTabPageChange = StreamController<int>.broadcast();

  set selectedBottomIndex(RxInt index){
    _selectedBottomIndex.value =  index.value;
    onTabPageChange.add(index.value);
  }

  RxInt get selectedBottomIndex =>_selectedBottomIndex;

}