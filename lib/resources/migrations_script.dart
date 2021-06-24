import '../constant/db_keys.dart';
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

/// List of migrations script for the [VERSION_3]
///
List<String> migrationScript3 = <String>[
  'Alter TABLE ${DBKey.ACCOUNT} ADD ${DBKey.INCOME}  REAL DEFAULT 0.0',
  'Alter TABLE ${DBKey.MONTHLY_SUMMARY} ADD ${DBKey.INCOME}  REAL DEFAULT 0.0',
  'Alter TABLE ${DBKey.TRANSACTION} ADD ${DBKey.TRANSACTION_TYPE}  STRING',
];
