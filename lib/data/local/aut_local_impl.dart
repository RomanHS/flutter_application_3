import 'package:collection/collection.dart';
import 'package:flutter_application_3/data/local/aut_local.dart';
import 'package:flutter_application_3/data/orm/db.dart';
import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/data/orm/mapper/settings_mapper.dart';
import 'package:flutter_application_3/data/orm/mapper/user_mapper.dart';
import 'package:flutter_application_3/data/orm/tables.dart';
import 'package:flutter_application_3/domain/aut.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/value/settings.dart';
import 'package:sqflite/sqflite.dart';

class AutLocalImpl implements AutLocal {
  final DB db;

  AutLocalImpl({
    required this.db,
  });

  @override
  Future<Aut> getAut() async {
    final List<User> users = await db.getObjects<User>(
      table: TableHeader.userTable,
      uidUser: null,
      uids: null,
      parse: (EntityDB e) => UserMapper.fromDB(e),
    );

    final List<Settings> settings = await db.getObjects<Settings>(
      table: TableHeader.settingsTable,
      uidUser: null,
      uids: null,
      parse: (EntityDB e) => SettingsMapper.fromDB(e),
    );

    return Aut(
      ///
      user: users.firstWhereOrNull((User user) => user.isAut) ?? User.empty(),

      ///
      users: users,

      ///
      settings: settings.firstOrNull ?? Settings.empty(),
    );
  }

  @override
  Future<void> transaction({
    required User? user,
    required Settings? settings,
    required String? uidUserDelete,
  }) =>
      db.database.transaction((Transaction txn) async {
        /// delete

        if (uidUserDelete != null) {
          await db.deleteEntitys(
            table: TableHeader.userTable,
            uidUser: null,
            uids: [uidUserDelete],
            txn: txn,
          );

          for (TableHeader t in TableHeader.values) {
            if (t.isUserKey == false) {
              continue;
            }

            await db.deleteEntitys(
              table: t,
              uidUser: uidUserDelete,
              uids: null,
              txn: txn,
            );
          }

          for (TableRegistr t in TableRegistr.values) {
            await db.deleteEntitysRegistrs(
              table: t,
              uidUser: uidUserDelete,
              uids: null,
              txn: txn,
            );
          }
        }

        /// put

        if (user != null) {
          await db.putObjects(
            table: TableHeader.userTable,
            uidUser: null,
            values: [user],
            parse: (User e) => UserMapper(e).toDB(),
            txn: txn,
          );
        }

        if (settings != null) {
          await db.putObjects(
            table: TableHeader.settingsTable,
            uidUser: null,
            values: [settings],
            parse: (Settings e) => SettingsMapper(e).toDB(),
            txn: txn,
          );
        }
      });
}
