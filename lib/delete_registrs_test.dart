import 'package:flutter_application_3/data/orm/db.dart';
import 'package:flutter_application_3/data/orm/entity/registr_entity.dart';
import 'package:flutter_application_3/data/orm/mapper/leftover_mapper.dart';
import 'package:flutter_application_3/data/orm/mapper/uid_leftover_mapper.dart';
import 'package:flutter_application_3/data/orm/tables.dart';
import 'package:flutter_application_3/domain/registr/leftover.dart';
import 'package:sqflite/sqflite.dart';

Future<void> deleteRegistrsTest(DB db) async {
  const String uidUser = '1';

  final List<Leftover> leftovers = [
    ...List.generate(5, (int i) => Leftover(uidProduct: (i + 1).toString(), uidWarehouse: '1', value: i + 1)),
    ...List.generate(5, (int i) => Leftover(uidProduct: (i + 1).toString(), uidWarehouse: '2', value: i + 1)),
  ];

  await db.database.transaction(
    (Transaction txn) => db.putRegistrs(
      table: TableRegistr.leftover,
      uidUser: uidUser,
      values: leftovers,
      parse: (Leftover e) => LeftoverMapper(e).toDB(uidUser: uidUser),
      txn: txn,
    ),
  );

  final List<Leftover> list1 =
      await db.getRegistrs(table: TableRegistr.leftover, uidUser: uidUser, parse: (RegistrEntityDB e) => LeftoverMapper.fromDB(e));

  await db.database.transaction(
    (Transaction txn) => db.deleteRegistrs(
      table: TableRegistr.leftover,
      uidUser: uidUser,
      uids: [
        const UidLeftover(uidProduct: null, uidWarehouse: '1'),
      ],
      parse: (UidLeftover e) => UidLeftoverMapper(e).toDB(uidUser: uidUser),
      txn: txn,
    ),
  );

  final List<Leftover> list2 =
      await db.getRegistrs(table: TableRegistr.leftover, uidUser: uidUser, parse: (RegistrEntityDB e) => LeftoverMapper.fromDB(e));

  list1;
  list2;
}
