import 'base_model.dart';

class Maintenance extends BaseModel {
  Maintenance({
    this.accessMode,
    this.targetMaximumVersion,
    this.startDate,
    this.endDate,
    this.dialogMessage,
    this.defaultButtonMessage,
    this.url,
    this.urlButtonMessage,
    Map<String, dynamic> json,
  }) : super(json: json);

  String accessMode;
  String targetMaximumVersion;
  DateTime startDate;
  DateTime endDate;
  String dialogTitle;
  String dialogMessage;
  String defaultButtonMessage;
  String url;
  String urlButtonMessage;

  @override
  void fromJson(Map<String, dynamic> json) {
    accessMode = json['AccessMode'];
    targetMaximumVersion = json['TargetMaximumAppVersion'];
    startDate = DateTime.tryParse(json['StartDate'])?.toLocal();
    endDate = DateTime.tryParse(json['EndDate'])?.toLocal();
    dialogTitle = json['DialogTitle'] ?? 'false';
    dialogMessage = json['DialogMessage'] ?? 'false';
    defaultButtonMessage = json['DefaultButtonMessage'];
    url = json['Url'];
    urlButtonMessage = json['UrButtonMessage'];
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'AccessMode': accessMode,
        'TargetMaximumAppVersion': startDate?.toString(),
        'StartDate': endDate?.toString(),
        'EndDate': dialogMessage,
        'DialogTitle': dialogTitle,
        'DialogMessage': dialogMessage,
        'DefaultButtonMessage': defaultButtonMessage,
        'Url': url,
        'UrButtonMessage': urlButtonMessage
      };

  @override
  void getValue() {}

  @override
  void setValue(dynamic value) {}
}
