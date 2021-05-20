abstract class BaseModel {
  BaseModel({
    this.createdAt,
    this.updatedAT,
    this.notIncludeInMapping,
    Map<String, dynamic> json,
  }) {
    if (json != null) {
      fromJson(json);
    }
    createdAt = createdAt ?? DateTime.now();
    updatedAT = updatedAT ?? DateTime.now();
  }

  DateTime createdAt;
  DateTime updatedAT;
  List<String> notIncludeInMapping;

  void fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  Map<String, dynamic> filterToJson(Map<String, dynamic> map) {
    if (notIncludeInMapping == null) {
      return map;
    }

    notIncludeInMapping.forEach(map.remove);
    return map;
  }
}
