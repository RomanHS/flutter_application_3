import 'dart:developer';
import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/data/orm/tables.dart';
import 'package:flutter_application_3/data/orm/tabular_part/tabular_part.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  final Database database;

  DB._({
    required this.database,
  });

  static Future<DB> init() async {
    const String path = 'db_6.db';

    await deleteDatabase(path);

    final Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database database, int v) async {
        for (TableHeader table in TableHeader.values) {
          final List<String> params = [
            'uid_user TEXT',
            'uid TEXT',
            ...table.createParams(),
          ];

          final String sql = 'CREATE TABLE ${table.name} (${params.join(', ')})';

          await database.execute(sql);
        }

        for (TableTab table in TableTab.values) {
          final List<String> params = [
            'uid_user TEXT',
            'uid_parent TEXT',
            ...table.createParams(),
          ];

          final String sql = 'CREATE TABLE ${table.name} (${params.join(', ')})';

          await database.execute(sql);
        }
      },
    );

    final List<Map<String, Object?>> r = await database.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");

    log(r.toString());

    return DB._(database: database);
  }

  Future<List<Entity>> getEntitys({
    required TableHeader table,
    required String uidUser,
    required Iterable<String>? uids,
  }) async {
    String sql = 'SELECT * FROM ${table.name} ';

    sql += 'WHERE uid_user = $uidUser ';

    if (uids != null) {
      sql += 'AND uid IN (${uids.join(',')})';
    }

    final List<Map<String, Object?>> list = await database.rawQuery(sql);

    final Map<String, Map<TableTab, List<Map<String, Object?>>>> tabularsParts = {};

    for (TableTab table in table.getTabs()) {
      String where = 'uid_user = $uidUser ';

      if (uids != null) {
        where += 'AND uid IN (${uids.join(',')})';
      }

      final List<Map<String, Object?>> list = await database.query(table.name, where: where);

      for (Map<String, Object?> json in list) {
        tabularsParts.putIfAbsent(json['uid_parent'] as String, () => {}).putIfAbsent(table, () => []).add(json);
      }
    }

    return list.map(
      (Map<String, Object?> e) {
        final String uid = e['uid'] as String;

        final Map<TableTab, List<Map<String, Object?>>> tabularParts = tabularsParts[uid] ?? {};

        return Entity(
          table: table,
          data: e,
          tabularParts: tabularParts.map((TableTab key, value) => MapEntry(
                key,
                value.map(
                  (Map<String, Object?> e) {
                    return TabularPart(
                      data: e,
                    );
                  },
                ).toList(),
              )),
        );
      },
    ).toList();
  }

  Future<void> put({
    required Entity entity,
  }) =>
      database.transaction((txn) async {
        final TableHeader table = entity.table;

        await txn.delete(
          table.name,
          where: 'uid = ${entity.uid}',
        );

        await txn.insert(
          table.name,
          entity.data,
        );

        for (MapEntry<TableTab, List<TabularPart>> e in entity.tabularParts.entries) {
          final TableTab table = e.key;
          final List<TabularPart> list = e.value;

          await txn.delete(
            table.name,
            where: 'uid_parent = ${entity.uid}',
          );

          for (TabularPart e in list) {
            await txn.insert(
              table.name,
              e.data,
            );
          }
        }
      });
}
