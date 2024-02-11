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
    const String path = 'db_9.db';

    // await deleteDatabase(path);

    final Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database database, int v) async {
        for (TableHeader table in TableHeader.values) {
          final List<String> params = [
            'uid_user TEXT',
            'uid TEXT',
            ...table.createParams,
          ];

          final String sql = 'CREATE TABLE ${table.name} (${params.join(', ')})';

          await database.execute(sql);
        }

        for (TableTable table in TableTable.values) {
          final List<String> params = [
            'uid_user TEXT',
            'uid_parent TEXT',
            ...table.createParams,
          ];

          final String sql = 'CREATE TABLE ${table.name} (${params.join(', ')})';

          await database.execute(sql);
        }
      },
    );

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
    String where = 'uid_user = $uidUser';

    if (uids != null) {
      where += ' AND uid IN (${uids.join(',')})';
    }

    final List<Map<String, Object?>> list = await database.query(table.name, where: where);

    final Map<String, Map<TableTable, List<TabularPart>>> tabularsParts = {};

    for (TableTable table in table.tables) {
      String where = 'uid_user = $uidUser';

      if (uids != null) {
        where += ' AND uid_parent IN (${uids.join(',')})';
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
          data: e,
          tabularParts: tabularsParts[uid] ?? {},
        );
      },
    ).toList();
  }

  Future<void> putObjects<T>({
    required TableHeader table,
    required String uidUser,
    required Iterable<T> objects,
    required Entity Function(T) parse,
  }) =>
      putEntitys(
        table: table,
        uidUser: uidUser,
        entitys: objects.map(parse),
      );

  Future<void> putEntitys({
    required TableHeader table,
    required String uidUser,
    required Iterable<Entity> entitys,
  }) =>
      database.transaction((Transaction txn) async {
        await _delete(
          table: table,
          uidUser: uidUser,
          uids: entitys.map((Entity e) => e.uid),
          txn: txn,
        );

        for (Entity entity in entitys) {
          await txn.insert(
            table.name,
            entity.data,
          );

          for (MapEntry<TableTable, List<TabularPart>> e in entity.tabularParts.entries) {
            final TableTable table = e.key;
            final List<TabularPart> list = e.value;

            for (TabularPart e in list) {
              await txn.insert(
                table.name,
                e.data,
              );
            }
          }
        }
      });

  Future<void> delete({
    required TableHeader table,
    required String uidUser,
    required Iterable<String>? uids,
  }) =>
      database.transaction((Transaction txn) => _delete(
            table: table,
            uidUser: uidUser,
            uids: uids,
            txn: txn,
          ));

  Future<void> _delete({
    required TableHeader table,
    required String uidUser,
    required Iterable<String>? uids,
    required Transaction txn,
  }) async {
    String where = 'uid_user = $uidUser';

    if (uids != null) {
      where += ' AND uid IN (${uids.join(',')})';
    }

    await txn.delete(table.name, where: where);

    for (TableTable table in table.tables) {
      String where = 'uid_user = $uidUser';

      if (uids != null) {
        where += ' AND uid_parent IN (${uids.join(',')})';
      }

      await txn.delete(table.name, where: where);
    }
  }
}
