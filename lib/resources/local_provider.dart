import 'package:mybudget/resources/resource_definition.dart';
import 'package:mybudget/resources/resource_helper.dart';

class LocalProvider{
  Future<void> upsert<T>(T data){
    ResourceDefinition def = ResourceHelper.get<T>();
    return null;
  }

  Future<T> get<T>(T data){
    return null;
  }

  Future<void> delete<T>(T data){
    return null;
  }

  Future<T> list<T>(T data){
    return null;
  }
}