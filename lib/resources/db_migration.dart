import 'package:sqflite/sqflite.dart';

const int VERSION_1 = 1;

final Map<int, dynamic> _migrationScript = <int, List<String>>{};

Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
  for (int i = oldVersion + 1; i <= newVersion; i++) {
    if (_migrationScript.containsKey(i)) {
      _executeMigrations(db, _migrationScript[i]);
    }
  }
}

void _executeMigrations(Database db, List<String> migrations) {
  for (final String script in migrations) {
    _executeMigration(db, script);
  }
}

void _executeMigration(Database db, String script) {
  db.execute(script);
}
