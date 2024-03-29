import 'package:flutter_application_3/data/local/data_local.dart';
import 'package:flutter_application_3/data/orm/db.dart';
import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/data/orm/entity/registr_entity.dart';
import 'package:flutter_application_3/data/orm/mapper/leftover_mapper.dart';
import 'package:flutter_application_3/data/orm/mapper/message_mapper.dart';
import 'package:flutter_application_3/data/orm/mapper/order_mapper.dart';
import 'package:flutter_application_3/data/orm/mapper/product_mapper.dart';
import 'package:flutter_application_3/data/orm/mapper/settings_user_mapper.dart';
import 'package:flutter_application_3/data/orm/mapper/uid_leftover_mapper.dart';
import 'package:flutter_application_3/data/orm/tables.dart';
import 'package:flutter_application_3/domain/data.dart';
import 'package:flutter_application_3/domain/entity/message_text.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/domain/registr/leftover.dart';
import 'package:flutter_application_3/domain/value/settings_user.dart';
import 'package:sqflite/sqflite.dart';

class DataLocalOrm implements DataLocal {
  final DB db;

  DataLocalOrm({
    required this.db,
  });

  @override
  Future<Data> get({
    required String uidUser,
  }) async {
    final List<SettingsUser> settings = await db.getObjects<SettingsUser>(
      table: TableHeader.settingsUserTable,
      uidUser: uidUser,
      uids: null,
      parse: (EntityDB e) => SettingsUserMapper.fromDB(e),
    );

    return Data(
      ///
      settings: settings.firstOrNull ?? SettingsUser.empty(),

      ///
      orders: await db.getObjects<Order>(
        table: TableHeader.orderTable,
        uidUser: uidUser,
        uids: null,
        parse: (EntityDB e) => OrderMapper.fromDB(e),
      ),

      ///
      products: await db.getObjects<Product>(
        table: TableHeader.productTable,
        uidUser: uidUser,
        uids: null,
        parse: (EntityDB e) => ProductMapper.fromDB(e),
      ),

      ///
      messages: await db.getObjects<MessageText>(
        table: TableHeader.message,
        uidUser: uidUser,
        uids: null,
        parse: (EntityDB e) => MessageMapper.fromDB(e),
      ),

      ///
      leftovers: await db.getRegistrs<Leftover>(
        table: TableRegistr.leftover,
        uidUser: uidUser,
        parse: (RegistrEntityDB e) => LeftoverMapper.fromDB(e),
      ),
    );
  }

  @override
  Future<void> transaction({
    required String uidUser,
    required SettingsUser? settings,
    required Iterable<Order>? orders,
    required Iterable<Product>? products,
    required Iterable<MessageText>? messages,
    required Iterable<Leftover>? leftovers,
    required Iterable<String>? ordersDelete,
    required Iterable<String>? productsDelete,
    required Iterable<String>? messagesDelete,
    required Iterable<UidLeftover>? leftoversDelete,
    required bool ordersClear,
    required bool productsClear,
    required bool messagesClear,
  }) =>
      db.database.transaction((Transaction txn) async {
        /// Clear

        if (ordersClear) {
          await db.deleteEntitys(
            table: TableHeader.orderTable,
            uidUser: uidUser,
            uids: null,
            txn: txn,
          );
        }

        if (productsClear) {
          await db.deleteEntitys(
            table: TableHeader.productTable,
            uidUser: uidUser,
            uids: null,
            txn: txn,
          );
        }

        if (messagesClear) {
          await db.deleteEntitys(
            table: TableHeader.message,
            uidUser: uidUser,
            uids: null,
            txn: txn,
          );
        }

        /// Delete

        if (ordersDelete != null) {
          await db.deleteEntitys(
            table: TableHeader.orderTable,
            uidUser: uidUser,
            uids: ordersDelete,
            txn: txn,
          );
        }

        if (productsDelete != null) {
          await db.deleteEntitys(
            table: TableHeader.productTable,
            uidUser: uidUser,
            uids: productsDelete,
            txn: txn,
          );
        }

        if (messagesDelete != null) {
          await db.deleteEntitys(
            table: TableHeader.message,
            uidUser: uidUser,
            uids: messagesDelete,
            txn: txn,
          );
        }

        if (leftoversDelete != null) {
          await db.deleteRegistrs(
            table: TableRegistr.leftover,
            uidUser: uidUser,
            uids: leftoversDelete,
            parse: (UidLeftover u) => UidLeftoverMapper(u).toDB(),
            txn: txn,
          );
        }

        /// Put

        if (settings != null) {
          await db.putObjects<SettingsUser>(
            table: TableHeader.settingsUserTable,
            uidUser: uidUser,
            values: [settings],
            parse: (SettingsUser s) => SettingsUserMapper(s).toDB(uidUser: uidUser),
            txn: txn,
          );
        }

        if (orders != null) {
          await db.putObjects<Order>(
            table: TableHeader.orderTable,
            uidUser: uidUser,
            values: orders,
            parse: (Order o) => OrderMapper(o).toDB(uidUser: uidUser),
            txn: txn,
          );
        }

        if (products != null) {
          await db.putObjects<Product>(
            table: TableHeader.productTable,
            uidUser: uidUser,
            values: products,
            parse: (Product p) => ProductMapper(p).toDB(uidUser: uidUser),
            txn: txn,
          );
        }

        if (messages != null) {
          await db.putObjects<MessageText>(
            table: TableHeader.message,
            uidUser: uidUser,
            values: messages,
            parse: (MessageText m) => MessageMapper(m).toDB(uidUser: uidUser),
            txn: txn,
          );
        }

        if (leftovers != null) {
          await db.putRegistrs<Leftover>(
            table: TableRegistr.leftover,
            uidUser: uidUser,
            values: leftovers,
            parse: (Leftover m) => LeftoverMapper(m).toDB(uidUser: uidUser),
            txn: txn,
          );
        }
      });
}
