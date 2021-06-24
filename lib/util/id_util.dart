import 'package:uuid/uuid.dart';

String randomID() => const Uuid().v1();

String monthlySummaryID({DateTime date}){
  final DateTime dateParam = date??DateTime.now();
  return '${dateParam.month}-${dateParam.year}';
}
