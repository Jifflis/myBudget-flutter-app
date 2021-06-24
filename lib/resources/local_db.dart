import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constant/db_keys.dart';
import 'db_migration.dart';

class LocalDB {
  ///set singleton instance of this class
  ///
  ///
  factory LocalDB() => _instance;

  LocalDB._();

  static final LocalDB _instance = LocalDB._();

  Database db;

  ///Initialize DB
  ///return true if the database is first created
  ///otherwise false
  Future<bool> initialize() async {
    final String path = join(await getDatabasesPath(), 'budget.db');
    final bool isFirstCreated = !File(path).existsSync();
    print(path);
    db = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      path,
      onCreate: (Database db, int version) {
        // Run the CREATE TABLE statement on the database.
        _createTableAccount(db);
        _createTableUser(db);
        _createTableMonthlySummary(db);
        _createTableTransaction(db);
        _createTableSettings(db);
        _createTableCurrency(db);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        upgrade(db, oldVersion, newVersion);
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      // Refer to db_migration.dart for list of versions
      // Please use db_migration.dart for version declaration.
      version: VERSION_3,
    );

    return isFirstCreated;
  }

  ///Create table account
  ///
  ///
  void _createTableAccount(Database db) {
    db.execute(
      'CREATE TABLE ${DBKey.ACCOUNT}('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '${DBKey.ACCOUNT_ID} TEXT NOT NULL UNIQUE,'
      '${DBKey.MONTHLY_SUMMARY_ID} TEXT,'
      '${DBKey.TITLE} STRING NOT NULL,'
      '${DBKey.BUDGET} REAL DEFAULT 0.0,'
      '${DBKey.EXPENSE} REAL DEFAULT 0.0,'
      '${DBKey.BALANCE} REAL DEFAULT 0.0,'
      '${DBKey.ADJUSTED} REAL DEFAULT 0.0,'
      '${DBKey.INCOME} REAL DEFAULT 0.0,'
      '${DBKey.AUTO_DEDUCT} NUMERIC,'
      '${DBKey.CREATED_AT} STRING,'
      '${DBKey.UPDATED_AT} STRING,'
      '${DBKey.USER_ID} STRING NOT NULL)',
    );
  }

  ///Create table user
  ///
  ///
  void _createTableUser(Database db) {
    db.execute(
      'CREATE TABLE ${DBKey.USER}('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '${DBKey.USER_ID} TEXT NOT NULL UNIQUE, '
      '${DBKey.NAME} STRING,'
      '${DBKey.EMAIL} STRING,'
      '${DBKey.PASSWORD} STRING,'
      '${DBKey.CREATED_AT} STRING,'
      '${DBKey.UPDATED_AT} STRING)',
    );
  }

  ///Create table ledger
  ///
  ///
  void _createTableMonthlySummary(Database db) {
    db.execute('CREATE TABLE ${DBKey.MONTHLY_SUMMARY} ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${DBKey.MONTHLY_SUMMARY_ID} TEXT NOT NULL UNIQUE,'
        '${DBKey.USER_ID} STRING NOT NULL,'
        '${DBKey.MONTH} INTEGER,'
        '${DBKey.YEAR} INTEGER,'
        '${DBKey.EXPENSE} REAL DEFAULT 0.0,'
        '${DBKey.BUDGET} REAL DEFAULT 0.0,'
        '${DBKey.ADJUSTED} REAL DEFAULT 0.0,'
        '${DBKey.INCOME} REAL DEFAULT 0.0,'
        '${DBKey.BALANCE} REAL DEFAULT 0.0,'
        '${DBKey.CREATED_AT} STRING NOT NULL,'
        '${DBKey.UPDATED_AT} STRING NOT NULL)');
  }

  ///Create table transaction
  ///
  ///
  void _createTableTransaction(Database db) {
    db.execute('CREATE TABLE ${DBKey.TRANSACTION} ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${DBKey.TRANSACTION_ID} TEXT NOT NULL UNIQUE,'
        '${DBKey.USER_ID} STRING NOT NULL,'
        '${DBKey.ACCOUNT_ID} STRING,'
        '${DBKey.AMOUNT} REAL,'
        '${DBKey.REMARKS} STRING,'
        '${DBKey.TRANSACTION_DATE} STRING,'
        '${DBKey.TRANSACTION_TYPE} STRING,'
        '${DBKey.CREATED_AT} STRING,'
        '${DBKey.UPDATED_AT} STRING)');
  }

  ///Create table currency
  ///
  ///
  void _createTableCurrency(Database db) {
    db.execute('CREATE TABLE ${DBKey.CURRENCY} ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${DBKey.CURRENCY_ID} TEXT NOT NULL UNIQUE,'
        '${DBKey.NAME} STRING,'
        '${DBKey.SYMBOL} STRING)');
  }

  ///Create table Settings
  ///
  ///
  void _createTableSettings(Database db) {
    db.execute('CREATE TABLE ${DBKey.SETTINGS} ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${DBKey.SETTINGS_ID} TEXT NOT NULL UNIQUE,'
        '${DBKey.USER_ID} STRING NOT NULL,'
        '${DBKey.FIRST_INSTALL} NUMERIC,'
        '${DBKey.REFRESH_DATE} STRING,'
        '${DBKey.CURRENCY_ID} STRING,'
        '${DBKey.CREATED_AT} STRING,'
        '${DBKey.UPDATED_AT} STRING)');
  }
}
