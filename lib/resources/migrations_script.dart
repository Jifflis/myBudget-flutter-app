import 'package:mybudget/constant/db_keys.dart';

import 'db_migration.dart';


/// Use this file for listing all migrations script
///
/// If the database schema is updated add new variable
/// with the naming convention of `migrationsScript` + `the version number`.
///
/// The created variable should contain the list of database script.
///

/// List of migrations script for the [VERSION_2]
///
List<String> migrationScript2 = <String>[
  'Alter TABLE ${DBKey.TRANSACTION} ADD ${DBKey.TRANSACTION_DATE} STRING'
];
