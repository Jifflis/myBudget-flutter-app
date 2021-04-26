import 'package:sqflite/sqflite.dart';

import 'local_db.dart';
import 'resource_definition.dart';
import 'resource_helper.dart';

class LocalProvider {
  ///Get instance of [Database] through instance of [LocalDB]
  ///
  ///
  Database db = LocalDB.instance().db;

  ///Insert or update data
  ///
  ///
  Future<int> upsert<T>(T data) async {
    final ResourceDefinition def = ResourceHelper.get<T>();
    return await db.insert(
      def.name,
      def.toMap(data),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  ///Update data using raw sql query
  ///Used this function only for updating specific column
  ///
  Future<int> rawUpdate(String query,[List<dynamic> arguments]){
    return db.rawUpdate(query,arguments);
  }

  ///Delete data
  ///
  ///
  Future<void> delete<T>({String where, List<dynamic> whereArgs}) {
    final ResourceDefinition def = ResourceHelper.get<T>();
    return db.delete(def.name, where: where, whereArgs: whereArgs);
  }

  ///Get single data
  ///
  ///
  Future<T> get<T>({
    List<String> columns,
    String where,
    List<dynamic> whereArgs,
    String having,
  }) async {
    final ResourceDefinition def = ResourceHelper.get<T>();

    final List<Map<String, dynamic>> map = await db.query(def.name,
        columns: columns, where: where, whereArgs: whereArgs, having: having);

    if (map == null || map.isEmpty) {
      return null;
    }
    return def.builder(map[0]) as T;
  }

  ///Get list of data
  ///
  ///
  Future<T> list<T>({
    bool distinct,
    List<String> columns,
    String where,
    List<dynamic> whereArgs,
    String groupBy,
    String having,
    String orderBy,
    int limit,
    int offset,
  }) async {
    final ResourceDefinition def = ResourceHelper.get<T>();

    final List<Map<String, dynamic>> map = await db.query(def.name,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);

    if (map == null || map.isEmpty) {
      return null;
    }

    return def.builder(map[0]) as T;
  }
}
