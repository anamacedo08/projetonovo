import 'package:sqflite/sqflite.dart';
import 'database_service.dart';

abstract class BaseRepository<T> {
  final DatabaseService dbService = DatabaseService();
  final String tableName;

  BaseRepository(this.tableName);

  Future<Database> get database => dbService.database;

  Future<int> insert(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(tableName, data);
  }

  Future<int> update(Map<String, dynamic> data, {String? where, List<Object?>? whereArgs}) async {
    final db = await database;
    return await db.update(tableName, data, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> query({
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await database;
    return await db.query(
      tableName,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  Future<int> delete({String? where, List<Object?>? whereArgs}) async {
    final db = await database;
    return await db.delete(tableName, where: where, whereArgs: whereArgs);
  }
}
