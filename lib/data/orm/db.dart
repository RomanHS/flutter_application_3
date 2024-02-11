import 'dart:developer';
import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  final Database database;

  DB._({
    required this.database,
  });

  static Future<DB> init() async {
    const String path = 'db_5.db';

    // await deleteDatabase(path);

    final Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database database, int v) async {
        for (String sql in Entity.creates()) {
          await database.execute(sql);

          log(sql);
        }
      },
    );

    final List<Map<String, Object?>> r = await database.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");

    log(r.toString());

    return DB._(database: database);
  }

  Future<List<TEntity>> getAllSql<TEntity extends Entity>({
    required String uidUser,
    required Iterable<String>? uids,
  }) async {
    String sql = 'SELECT * FROM ${TEntity.toString()} ';

    sql += 'WHERE uid_user = $uidUser ';

    if (uids != null) {
      sql += 'AND uid IN (${uids.join(',')})';
    }

    final List<Map<String, Object?>> list = await database.rawQuery(sql);

    final Map<String, Map<String, List<Map<String, Object?>>>> tabularParts = {};

    for (String table in Entity.getTables<TEntity>()) {
      String where = 'uid_user = $uidUser ';

      if (uids != null) {
        where += 'AND uid IN (${uids.join(',')})';
      }

      final List<Map<String, Object?>> list = await database.query(table, where: where);

      for (Map<String, Object?> json in list) {
        tabularParts.putIfAbsent(json['uid_parent'] as String, () => {}).putIfAbsent(table, () => []).add(json);
      }
    }

    return list.map((Map<String, Object?> e) => Entity.parse<TEntity>(e, tabularParts[e['uid']] ?? {})).toList();
  }

  Future<void> put({
    required Entity entity,
  }) =>
      database.transaction((txn) async {
        final String table = entity.runtimeType.toString();

        await txn.delete(
          table,
          where: 'uid = ${entity.uid}',
        );

        await txn.insert(
          table,
          entity.to(),
        );

        for (MapEntry<String, List<Map<String, Object?>>> e in entity.toTabularParts().entries) {
          final String table = e.key;
          final List<Map<String, Object?>> list = e.value;

          await txn.delete(
            table,
            where: 'uid_parent = ${entity.uid}',
          );

          for (Map<String, Object?> e in list) {
            await txn.insert(
              table,
              e,
            );
          }
        }
      });
}
