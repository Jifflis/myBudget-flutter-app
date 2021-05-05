import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constant/db_keys.dart';

class LocalDB {
  LocalDB._();

  static LocalDB _instance;
  Database db;

  ///Get singleton instance of this class
  ///
  ///
  static LocalDB instance() {
    _instance ??= LocalDB._();
    return _instance;
  }

  ///Initialize DB
  ///return true if the database is first created
  ///otherwise false
  Future<bool> initialize() async {
    final String path = join(await getDatabasesPath(), 'budget.db');
    final bool isFirstCreated = !File(path).existsSync();

    db = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      path,
      onCreate: (Database db, int version) {
        // Run the CREATE TABLE statement on the database.
        _createTableAccount(db);
        _createTableUser(db);
        _createTableLedger(db);
        _createTableTransaction(db);
        _createTableSettings(db);
        _createTableCurrency(db);
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 2,
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
      '${DBKey.ACCOUNT_ID} TEXT NOT NULL UNIQUE, '
      '${DBKey.TITLE} STRING,'
      '${DBKey.BUDGET} REAL,'
      '${DBKey.EXPENSE} REAL,'
      '${DBKey.BALANCE} REAL,'
      '${DBKey.ADJUSTED} REAL,'
      '${DBKey.CREATED_AT} STRING,'
      '${DBKey.UPDATED_AT} STRING,'
      '${DBKey.USER_ID} STRING)',
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
  void _createTableLedger(Database db) {
    db.execute('CREATE TABLE ${DBKey.LEDGER} ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${DBKey.LEDGER_ID} TEXT NOT NULL UNIQUE,'
        '${DBKey.ACCOUNT_ID} STRING,'
        '${DBKey.BEGINNING_BALANCE} REAL,'
        '${DBKey.ENDING_BALANCE} REAL,'
        '${DBKey.EXPENSE} REAL,'
        '${DBKey.BUDGET} REAL,'
        '${DBKey.ADJUSTED} REAL,'
        '${DBKey.STATUS} STRING,'
        '${DBKey.MONTH} INTEGER,'
        '${DBKey.YEAR} INTEGER,'
        '${DBKey.CREATED_AT} STRING,'
        '${DBKey.UPDATED_AT} STRING,'
        '${DBKey.USER_ID} STRING)');
  }

  ///Create table transaction
  ///
  ///
  void _createTableTransaction(Database db) {
    db.execute('CREATE TABLE ${DBKey.TRANSACTION} ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${DBKey.TRANSACTION_ID} TEXT NOT NULL UNIQUE,'
        '${DBKey.USER_ID} STRING,'
        '${DBKey.ACCOUNT_ID} STRING,'
        '${DBKey.AMOUNT} REAL,'
        '${DBKey.REMARKS} STRING,'
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
        '${DBKey.USER_ID} STRING,'
        '${DBKey.FIRST_INSTALL} NUMERIC,'
        '${DBKey.REFRESH_DATE} STRING,'
        '${DBKey.CURRENCY_ID} STRING,'
        '${DBKey.CREATED_AT} STRING,'
        '${DBKey.UPDATED_AT} STRING)');
  }
}
