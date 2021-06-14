import 'package:sqflite/sqflite.dart';

import 'migrations_script.dart';

/// List of database versions
///
/// Add new version variable here if the database schema is updated
/// Please follow the naming convention of `VERSION_` + `the new version number`.
///
const int VERSION_1 = 1;
const int VERSION_2 = 2;


/// List of migrations script
///
/// It contains the map of the database version number and their corresponding script.
///
/// Add new items if the database schema is updated.
/// This will be read during the [upgrade] logic.
///
final Map<int, dynamic> _migrationScript = <int, List<String>>{
  VERSION_2: migrationScript2,
};

/// A logic for updating the database schema.
///
/// This will be called if you will increment the version number in the [local_db.dart]
/// under initialize method.
///
/// It will read and execute the migrations script from the [_migrationScript]
/// if the old version is greater than new version
///
Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
  for (int i = oldVersion + 1; i <= newVersion; i++) {
    if (_migrationScript.containsKey(i)) {
      _executeMigrations(db, _migrationScript[i]);
    }
  }
}

/// Loop in the migration param and execute the script
///
void _executeMigrations(Database db, List<String> migrations) {
  for (final String script in migrations) {
    _executeMigration(db, script);
  }
}

/// Actual execution of the database script
///
void _executeMigration(Database db, String script) {
  db.execute(script);
}
