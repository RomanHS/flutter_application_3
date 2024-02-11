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
    const String path = 'db_8.db';

    // await deleteDatabase(path);

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

    // final List<Map<String, Object?>> r = await database.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");

    // log(r.toString());

    return DB._(database: database);
  }

  Future<List<T>> getObjects<T>({
    required TableHeader table,
    required String uidUser,
    required Iterable<String>? uids,
    required T Function(Entity) parse,
  }) async =>
      (await getEntitys(
        table: table,
        uidUser: uidUser,
        uids: uids,
      ))
          .map(parse)
          .toList();

  Future<List<Entity>> getEntitys({
    required TableHeader table,
    required String uidUser,
    required Iterable<String>? uids,
  }) async {
    String where = 'uid_user = $uidUser ';

    if (uids != null) {
      where += 'AND uid IN (${uids.join(',')})';
    }

    final List<Map<String, Object?>> list = await database.query(table.name, where: where);

    final Map<String, Map<TableTab, List<TabularPart>>> tabularsParts = {};

    for (TableTab table in table.tabs) {
      String where = 'uid_user = $uidUser ';

      if (uids != null) {
        where += 'AND uid_parent IN (${uids.join(',')})';
      }

      final List<Map<String, Object?>> list = await database.query(table.name, where: where);

      for (Map<String, Object?> json in list) {
        final TabularPart tabularPart = TabularPart(data: json);

        tabularsParts.putIfAbsent(tabularPart.uidParent, () => {}).putIfAbsent(table, () => []).add(tabularPart);
      }
    }

    return list.map(
      (Map<String, Object?> e) {
        final String uid = e['uid'] as String;

        return Entity(
          table: table,
          data: e,
          tabularParts: tabularsParts[uid] ?? {},
        );
      },
    ).toList();
  }

  Future<void> putObjects<T>({
    required Iterable<T> objects,
    required Entity Function(T) parse,
  }) =>
      putEntitys(objects.map(parse));

  Future<void> putEntitys(Iterable<Entity> entitys) async {
    for (Entity e in entitys) {
      await put(e);
    }
  }

  Future<void> put(Entity entity) => database.transaction((Transaction txn) async {
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
