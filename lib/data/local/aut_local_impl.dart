import 'package:collection/collection.dart';
import 'package:flutter_application_3/data/local/aut_local.dart';
import 'package:flutter_application_3/data/orm/db.dart';
import 'package:flutter_application_3/data/orm/entity/entity.dart';
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
  Future<Aut> getAut() async => Aut(
        ///
        user: (await db.getObjects<User>(
              table: TableHeader.userTable,
              uidUser: null,
              uids: null,
              parse: (EntityDB e) => UserMapper.fromDB(e),
            ))
                .firstWhereOrNull((User user) => user.isAut) ??
            User.empty(),

        ///
        settings: Settings.empty(),
      );

  @override
  Future<void> transaction({
    required User? user,
    required Settings? settings,
  }) =>
      db.database.transaction((Transaction txn) async {
        if (user != null) {
          await db.putObjects(
            table: TableHeader.userTable,
            uidUser: null,
            values: [user],
            parse: (User e) => UserMapper(e).toDB(),
            txn: txn,
          );
        }
      });
}
