import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mybudget/controller/base_controller.dart';

class ImageSelectorController extends BaseController{
  final MethodChannel _platform = const MethodChannel('com.sakayta.mybudget/image');
  File _imageFile;
  String _imagePath;
  String _imageName;


  /// get data [_platform]
  /// 
  /// 
  MethodChannel get platform => _platform;

  /// get data [_imagePath]
  /// 
  /// 
  String get imagePath => _imagePath;

  /// set data [_imagePath]
  /// 
  /// 
  set imagePath(String val){
    _imagePath = val;
    update();
  }

  /// get data [_imageName]
  /// 
  /// 
  String get imageName => _imageName;

  /// set data [_imageName]
  /// 
  /// 
  set imageName(String val) {
    _imageName = val;
    update();
  }

  /// get data [_file]
  /// 
  /// 
  File get imageFile => _imageFile;

  /// set data [_file]
  /// 
  /// 
  set imageFile(File val){
    _imageFile = val;
    update();
  }

  /// initialize imageFile
  /// 
  /// 
  Future<void> initImagefile(String name) async {
    _imageName = name.replaceAll(RegExp(' '), '_');
    _imageFile = null;
    
    _imagePath = await _platform.invokeMethod(
      'getPath',
      <dynamic, String>{
        'name':'img_$_imageName',
      }
    );
    
    if(_imagePath != null){
      _imageFile = File(_imagePath);
    }

    update();
  }

  /// save image
  /// 
  /// 
  Future<String> saveImage() async {
    try{
      final String path = await _platform.invokeMethod(
        'saveImage',
        <dynamic, String>{
          'name':'img_$_imageName',
          'path' : _imagePath,
        }
      );
      return path;
    }catch(e){
      return null;
    }
  }

  /// get bool if has changes
  /// 
  /// 
  bool get changes{
    if(_imageFile == null){
      return false;
    }

    final List<String> splitPath = _imageFile.path.split('/');
    if(splitPath[splitPath.length - 1] == 'img_$_imageName.jpg'){
      return false;
    }

    return true;
  }

  /// reset properties
  /// 
  /// 
  Future<void> reset() async{
    imageCache.clear();
    imageCache.clearLiveImages();
    _imageFile = null;
    _imagePath = null;
    _imageName = null;
    update();
  }
}