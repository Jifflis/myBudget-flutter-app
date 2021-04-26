import 'package:flutter/material.dart';

class ResourceDefinition {
  ResourceDefinition({
    @required this.type,
    @required this.builder,
    @required this.name,
    @required this.toMap,
  });
  
  Type type;
  Function builder;
  String name;
  Function toMap;
}
