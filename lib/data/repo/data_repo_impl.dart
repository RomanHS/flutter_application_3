import 'package:flutter_application_3/data/orm/db.dart';
import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/data/orm/mapper/message_mapper.dart';
import 'package:flutter_application_3/data/orm/mapper/order_mapper.dart';
import 'package:flutter_application_3/data/orm/mapper/product_mapper.dart';
import 'package:flutter_application_3/data/orm/tables.dart';
import 'package:flutter_application_3/domain/data.dart';
import 'package:flutter_application_3/domain/entity/message.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/domain/repo/data_repo.dart';

class DataRepoImpl implements DataRepo {
  final DB db;

  DataRepoImpl({
    required this.db,
  });

  @override
  Future<Data> get({
    required String uidUser,
  }) async =>
      Data(
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
        messages: await db.getObjects<Message>(
          table: TableHeader.message,
          uidUser: uidUser,
          uids: null,
          parse: (EntityDB e) => MessageMapper.fromDB(e),
        ),
      );

  @override
  Future<void> put({
    required String uidUser,
    required Iterable<Order>? orders,
    required Iterable<Product>? products,
    required Iterable<Message>? messages,
    required Iterable<String>? ordersDelete,
    required Iterable<String>? productsDelete,
    required Iterable<String>? messagesDelete,
  }) async {
    if (orders != null) {
      await db.putObjects<Order>(
        table: TableHeader.orderTable,
        uidUser: uidUser,
        objects: orders,
        parse: (Order o) => OrderMapper(o).toDB(uidUser: uidUser),
      );
    }

    if (products != null) {
      await db.putObjects<Product>(
        table: TableHeader.productTable,
        uidUser: uidUser,
        objects: products,
        parse: (Product p) => ProductMapper(p).toDB(uidUser: uidUser),
      );
    }

    if (messages != null) {
      await db.putObjects<Message>(
        table: TableHeader.message,
        uidUser: uidUser,
        objects: messages,
        parse: (Message m) => MessageMapper(m).toDB(uidUser: uidUser),
      );
    }

    if (ordersDelete != null) {
      await db.delete(
        table: TableHeader.orderTable,
        uidUser: uidUser,
        uids: ordersDelete,
      );
    }

    if (productsDelete != null) {
      await db.delete(
        table: TableHeader.productTable,
        uidUser: uidUser,
        uids: productsDelete,
      );
    }

    if (messagesDelete != null) {
      await db.delete(
        table: TableHeader.message,
        uidUser: uidUser,
        uids: messagesDelete,
      );
    }
  }
}
