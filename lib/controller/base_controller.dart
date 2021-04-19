import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BaseController extends GetxController{
  Status _status;
  String _message;


  set status (Status status){
    _status = status;
    update();
  }

  Status get status =>_status;

  set message(String message){
    _message = message;
    update();
  }

}

enum Status { LOADING, COMPLETED, ERROR }