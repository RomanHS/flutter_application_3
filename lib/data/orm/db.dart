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
    const String path = 'db_9.db';

    // await deleteDatabase(path);

    Future<void> onCreate(Database database, List<TableHeader> header, List<TableTable> table, List<TableRegistr> registrs) async {
      for (TableHeader table in header) {
        final List<String> params = [
          'uid_user TEXT',
          'uid TEXT',
          ...table.createParams,
        ];

        final String sql = 'CREATE TABLE ${table.name} (${params.join(', ')})';

        await database.execute(sql);
      }

      for (TableTable table in table) {
        final List<String> params = [
          'uid_user TEXT',
          'uid_parent TEXT',
          ...table.createParams,
        ];

        final String sql = 'CREATE TABLE ${table.name} (${params.join(', ')})';

        await database.execute(sql);
      }

      for (TableRegistr table in registrs) {
        final List<String> params = [
          'uid_user TEXT',
          ...table.createParams,
        ];

        final String sql = 'CREATE TABLE ${table.name} (${params.join(', ')})';

        await database.execute(sql);
      }
    }

    final Database database = await openDatabase(
      path,
      version: 4,

      ///
      onCreate: (Database database, int v) async {
        await onCreate(database, TableHeader.values, TableTable.values, TableRegistr.values);
      },

      ///
      onUpgrade: (Database database, int vO, int vN) async {
        log('vO: $vO, vN: $vN');

        if (vO < 2) {
          await onCreate(database, [TableHeader.productTable], [], []);
        }

        if (vO < 3) {
          await onCreate(database, [TableHeader.message], [TableTable.messageSurvey], []);
        }

        if (vO < 4) {
          await onCreate(database, [], [], [TableRegistr.leftover]);
        }
      },
    );

    return DB._(database: database);
  }

  Future<List<T>> getObjects<T>({
    required TableHeader table,
    required String uidUser,
    required Iterable<String>? uids,
    required T Function(EntityDB) parse,
  }) async =>
      (await getEntitys(
        table: table,
        uidUser: uidUser,
        uids: uids,
      ))
          .map(parse)
          .toList();

  Future<void> putObjects<T>({
    required TableHeader table,
    required String uidUser,
    required Iterable<T> objects,
    required EntityDB Function(T) parse,
    required Transaction txn,
  }) =>
      putEntitys(
        table: table,
        uidUser: uidUser,
        entitys: objects.map(parse),
        txn: txn,
      );

  Future<List<EntityDB>> getEntitys({
    required TableHeader table,
    required String uidUser,
    required Iterable<String>? uids,
  }) async {
    String where = 'uid_user = $uidUser';

    if (uids != null) {
      where += ' AND uid IN (${uids.map((String e) => '"$e"').join(',')})';
    }

    final List<Map<String, Object?>> list = await database.query(table.name, where: where);

    final Map<String, Map<TableTable, List<TabularPart>>> tabularsParts = {};

    for (TableTable table in table.tables) {
      String where = 'uid_user = $uidUser';

      if (uids != null) {
        where += ' AND uid_parent IN (${uids.map((String e) => '"$e"').join(',')})';
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

        return EntityDB(
          data: e,
          tabularParts: tabularsParts[uid] ?? {},
        );
      },
    ).toList();
  }

  Future<void> putEntitys({
    required TableHeader table,
    required String uidUser,
    required Iterable<EntityDB> entitys,
    required Transaction txn,
  }) async {
    final List<EntityDB> entitysList = entitys.toList();

    await delete(
      table: table,
      uidUser: uidUser,
      uids: entitysList.map((EntityDB e) => e.uid),
      txn: txn,
    );

    for (EntityDB entity in entitysList) {
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
  }

  Future<void> delete({
    required TableHeader table,
    required String uidUser,
    required Iterable<String>? uids,
    required Transaction txn,
  }) async {
    String where = 'uid_user = $uidUser';

    if (uids != null) {
      where += ' AND uid IN (${uids.map((String e) => '"$e"').join(',')})';
    }

    await txn.delete(table.name, where: where);

    for (TableTable table in table.tables) {
      String where = 'uid_user = $uidUser';

      if (uids != null) {
        where += ' AND uid_parent IN (${uids.map((String e) => '"$e"').join(',')})';
      }

      await txn.delete(table.name, where: where);
    }
  }
}
