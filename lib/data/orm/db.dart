import 'dart:developer';
import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/data/orm/entity/registr_entity.dart';
import 'package:flutter_application_3/data/orm/tables.dart';
import 'package:flutter_application_3/data/orm/tabular_part/tabular_part.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  final Database database;

  DB._({
    required this.database,
  });

  static Future<DB> init() async {
    const String path = 'db_20.db';

    // await deleteDatabase(path);

    Future<void> onCreate(Database database, List<TableHeader> header, List<TableTable> table, List<TableRegistr> registrs) async {
      for (TableHeader table in header) {
        final bool isUserKey = table.isUserKey;

        final List<String> params = [
          if (isUserKey) 'uid_user TEXT',
          'uid TEXT',
          ...table.createParams,
        ];

        final List<String> keys = [
          if (isUserKey) 'uid_user',
          'uid',
        ];

        // final String foreignKey = isUserKey ? ', FOREIGN KEY(uid_user) REFERENCES ${TableHeader.userTable.name}(uid) ON DELETE CASCADE' : '';

        const String foreignKey = '';

        final String sql = 'CREATE TABLE ${table.name} (${params.join(', ')}, PRIMARY key (${keys.join(', ')})$foreignKey)';

        await database.execute(sql);
      }

      for (TableTable table in table) {
        final bool isUserKey = table.isUserKey;

        final List<String> params = [
          if (isUserKey) 'uid_user TEXT',
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

        final List<String> keys = [
          'uid_user',
          ...table.keys,
        ];

        final String sql = 'CREATE TABLE ${table.name} (${params.join(', ')}, PRIMARY key (${keys.join(', ')}))';

        await database.execute(sql);
      }
    }

    final Database database = await openDatabase(
      ///
      path,

      ///
      version: 2,

      ///
      onCreate: (Database database, int v) async {
        await onCreate(database, TableHeader.values, TableTable.values, TableRegistr.values);
      },

      ///
      onUpgrade: (Database database, int vO, int vN) async {
        log('vO: $vO, vN: $vN');

        if (vO < 2) {
          // final String sql = 'ALTER TABLE ${TableHeader.orderTable.name} ADD COLUMN is_receipt INTEGER DEFAULT 0';

          // await database.execute(sql);

          await onCreate(database, [TableHeader.settingsUserTable], [], []);
        }

        // if (vO < 3) {
        //   await onCreate(database, [TableHeader.message], [TableTable.messageSurvey], []);
        // }

        // if (vO < 4) {
        //   await onCreate(database, [], [], [TableRegistr.leftover]);
        // }
      },
    );

    // database.execute('PRAGMA Foreign_keys = ON;');

    return DB._(database: database);
  }

  Future<List<T>> getObjects<T>({
    required TableHeader table,
    required String? uidUser,
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

  Future<List<T>> getRegistrs<T>({
    required TableRegistr table,
    required String uidUser,
    // required Iterable<String>? uids,
    required T Function(RegistrEntityDB) parse,
  }) async =>
      (await getEntitysRegistrs(
        table: table,
        uidUser: uidUser,
        // uids: uids,
      ))
          .map(parse)
          .toList();

  Future<void> putObjects<T>({
    required TableHeader table,
    required String? uidUser,
    required Iterable<T> values,
    required EntityDB Function(T) parse,
    required Transaction txn,
  }) =>
      putEntitys(
        table: table,
        uidUser: uidUser,
        values: values.map(parse),
        txn: txn,
      );

  Future<void> putRegistrs<T>({
    required TableRegistr table,
    required String uidUser,
    required Iterable<T> values,
    required RegistrEntityDB Function(T) parse,
    required Transaction txn,
  }) =>
      putEntitysRegistrs(
        table: table,
        uidUser: uidUser,
        values: values.map(parse),
        txn: txn,
      );

  Future<void> deleteRegistrs<T>({
    required TableRegistr table,
    required String uidUser,
    required Iterable<T>? uids,
    required UidRegistrEntityDB Function(T) parse,
    required Transaction txn,
  }) =>
      deleteEntitysRegistrs(
        table: table,
        uidUser: uidUser,
        uids: uids?.map(parse),
        txn: txn,
      );

  Future<List<EntityDB>> getEntitys({
    required TableHeader table,
    required String? uidUser,
    required Iterable<String>? uids,
  }) async {
    String where = '';

    if (uidUser != null) {
      where += 'uid_user = "$uidUser"';
    }

    if (uids != null) {
      if (where.isNotEmpty) {
        where += ' AND ';
      }

      where += 'uid IN (${uids.map((String e) => '"$e"').join(',')})';
    }

    final List<Map<String, Object?>> list = await database.query(table.name, where: where.isEmpty ? null : where);

    final Map<String, Map<TableTable, List<TabularPart>>> tabularsParts = {};

    for (TableTable table in table.tables) {
      String where = '';

      if (uidUser != null) {
        where += 'uid_user = "$uidUser"';
      }

      if (uids != null) {
        if (where.isNotEmpty) {
          where += ' AND ';
        }

        where += 'uid_parent IN (${uids.map((String e) => '"$e"').join(',')})';
      }

      final List<Map<String, Object?>> list = await database.query(table.name, where: where.isEmpty ? null : where);

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

  Future<List<RegistrEntityDB>> getEntitysRegistrs({
    required TableRegistr table,
    required String uidUser,
  }) async {
    String where = 'uid_user = "$uidUser"';

    // if (uids != null) {
    //   where += ' AND uid IN (${uids.map((String e) => '"$e"').join(',')})';
    // }

    final List<Map<String, Object?>> list = await database.query(table.name, where: where);

    return list.map((Map<String, Object?> e) => RegistrEntityDB(data: e)).toList();
  }

  Future<void> putEntitys({
    required TableHeader table,
    required String? uidUser,
    required Iterable<EntityDB> values,
    required Transaction txn,
  }) async {
    final List<EntityDB> entitysList = values.toList();

    await _deleteTables(
      tables: table.tables,
      uidUser: uidUser,
      uids: entitysList.map((EntityDB e) => e.uid),
      txn: txn,
    );

    final Batch batch = txn.batch();

    for (EntityDB entity in entitysList) {
      batch.insert(
        table.name,
        entity.data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      for (MapEntry<TableTable, List<TabularPart>> e in entity.tabularParts.entries) {
        final TableTable table = e.key;
        final List<TabularPart> list = e.value;

        for (TabularPart e in list) {
          batch.insert(
            table.name,
            e.data,
          );
        }
      }
    }

    await batch.commit();
  }

  Future<void> putEntitysRegistrs({
    required TableRegistr table,
    required String uidUser,
    required Iterable<RegistrEntityDB> values,
    required Transaction txn,
  }) async {
    final Batch batch = txn.batch();

    for (RegistrEntityDB value in values) {
      batch.insert(
        table.name,
        value.data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
  }

  Future<void> deleteEntitys({
    required TableHeader table,
    required String? uidUser,
    required Iterable<String>? uids,
    required Transaction txn,
  }) async {
    String where = '';

    if (uidUser != null) {
      where += 'uid_user = "$uidUser"';
    }

    if (uids != null) {
      if (where.isNotEmpty) {
        where += ' AND ';
      }

      where += 'uid IN (${uids.map((String e) => '"$e"').join(',')})';
    }

    await txn.delete(table.name, where: where.isEmpty ? null : where);

    await _deleteTables(
      tables: table.tables,
      uidUser: uidUser,
      uids: uids,
      txn: txn,
    );
  }

  Future<void> _deleteTables({
    required Iterable<TableTable> tables,
    required String? uidUser,
    required Iterable<String>? uids,
    required Transaction txn,
  }) async {
    for (TableTable table in tables) {
      String where = '';

      if (uidUser != null) {
        where = 'uid_user = "$uidUser"';
      }

      if (uids != null) {
        if (where.isNotEmpty) {
          where += ' AND ';
        }

        where += 'uid_parent IN (${uids.map((String e) => '"$e"').join(',')})';
      }

      await txn.delete(table.name, where: where.isEmpty ? null : where);
    }
  }

  Future<void> deleteEntitysRegistrs({
    required TableRegistr table,
    required String uidUser,
    required Iterable<UidRegistrEntityDB>? uids,
    required Transaction txn,
  }) async {
    if (uids == null) {
      String where = 'uid_user = "$uidUser"';

      await txn.delete(table.name, where: where);
    }
    //
    else {
      for (UidRegistrEntityDB uid in uids) {
        String where = 'uid_user = "$uidUser"';

        for (MapEntry<String, Object?> e in uid.keys.entries) {
          final String key = e.key;
          final Object? value = e.value;

          if (value != null) {
            if (value is String) {
              where += ' AND $key = "$value"';
            }
            //
            else {
              where += ' AND $key = $value';
            }
          }
        }

        await txn.delete(table.name, where: where);
      }
    }
  }
}
