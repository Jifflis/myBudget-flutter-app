import 'package:uuid/uuid.dart';

String randomID() => Uuid().v1();

String monthlySummaryID() => '${DateTime.now().month}-${DateTime.now().year}';
