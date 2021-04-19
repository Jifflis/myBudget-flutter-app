import '../model/account.dart';
import 'resource_definition.dart';

class ResourceHelper {
  static final List<ResourceDefinition> _resources = <ResourceDefinition>[
    ResourceDefinition(
      type: Account,
      builder: (Map<String, dynamic> json) => Account(json: json),
      name: 'Account',
      toMap: (Account account)=>account.toJson(),
    )
  ];

  static ResourceDefinition get<T>() => _resources
      .singleWhere((ResourceDefinition resource) => resource.type == T);
}
