import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_3/data/orm/db.dart';
import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/data/orm/mapper/message_mapper.dart';
import 'package:flutter_application_3/data/orm/mapper/order_mapper.dart';
import 'package:flutter_application_3/data/orm/mapper/product_mapper.dart';
import 'package:flutter_application_3/data/orm/tables.dart';
import 'package:flutter_application_3/domain/entity/message.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/domain/value/excise_tax.dart';
import 'package:flutter_application_3/domain/value/message_survey.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';

Future<void> test() async {
  const String uidUser = '1';

  final DB db = await DB.init();

  final List<Order> orders = getOrders();
  final List<Product> products = getProducts();
  final List<Message> messages = getMessages();

  /// put
  await db.database.transaction((txn) async {
    await db.putObjects<Order>(
      table: TableHeader.orderTable,
      uidUser: uidUser,
      values: orders,
      parse: (Order o) => OrderMapper(o).toDB(uidUser: uidUser),
      txn: txn,
    );

    await db.putObjects<Product>(
      table: TableHeader.productTable,
      uidUser: uidUser,
      values: products,
      parse: (Product p) => ProductMapper(p).toDB(uidUser: uidUser),
      txn: txn,
    );

    await db.putObjects<Message>(
      table: TableHeader.message,
      uidUser: uidUser,
      values: messages,
      parse: (Message m) => MessageMapper(m).toDB(uidUser: uidUser),
      txn: txn,
    );
  });

  /// get
  final List<Order> ordersDB = await db.getObjects<Order>(
    table: TableHeader.orderTable,
    uidUser: uidUser,
    uids: null,
    parse: (EntityDB e) => OrderMapper.fromDB(e),
  );

  final List<Product> productsDB = await db.getObjects<Product>(
    table: TableHeader.productTable,
    uidUser: uidUser,
    uids: null,
    parse: (EntityDB e) => ProductMapper.fromDB(e),
  );

  final List<Message> messagesDB = await db.getObjects<Message>(
    table: TableHeader.message,
    uidUser: uidUser,
    uids: null,
    parse: (EntityDB e) => MessageMapper.fromDB(e),
  );

  /// equals
  final bool isEqualsOrders = listEquals(orders, ordersDB);
  final bool isEqualsProducts = listEquals(products, productsDB);
  final bool isEqualsMessages = listEquals(messages, messagesDB);

  log('orders:   ${orders.map((Order o) => o.uid).toList()}');
  log('ordersDB: ${ordersDB.map((Order o) => o.uid).toList()}');
  log('isEquals orders: $isEqualsOrders');

  log('products:   ${products.map((Product p) => p.uid).toList()}');
  log('productsDB: ${productsDB.map((Product p) => p.uid).toList()}');
  log('isEquals products: $isEqualsProducts');

  log('messages:   ${messages.map((Message m) => m.uid).toList()}');
  log('messagesDB: ${messagesDB.map((Message m) => m.uid).toList()}');
  log('isEquals messages: $isEqualsMessages');

  /// delete
  {
    await db.database.transaction((txn) async {
      await db.delete(
        table: TableHeader.orderTable,
        uidUser: uidUser,
        uids: ['2', '3'],
        txn: txn,
      );

      await db.delete(
        table: TableHeader.productTable,
        uidUser: uidUser,
        uids: null,
        txn: txn,
      );

      await db.delete(
        table: TableHeader.message,
        uidUser: uidUser,
        uids: null,
        txn: txn,
      );
    });

    final List<Order> ordersDB = await db.getObjects<Order>(
      table: TableHeader.orderTable,
      uidUser: uidUser,
      uids: null,
      parse: (EntityDB e) => OrderMapper.fromDB(e),
    );

    final List<Product> productsDB = await db.getObjects<Product>(
      table: TableHeader.productTable,
      uidUser: uidUser,
      uids: null,
      parse: (EntityDB e) => ProductMapper.fromDB(e),
    );

    final List<Message> messagesDB = await db.getObjects<Message>(
      table: TableHeader.message,
      uidUser: uidUser,
      uids: null,
      parse: (EntityDB e) => MessageMapper.fromDB(e),
    );

    log('delete orders:   ${ordersDB.map((Order o) => o.uid).toList()}');
    log('delete products: ${productsDB.map((Product p) => p.uid).toList()}');
    log('delete messages: ${messagesDB.map((Message m) => m.uid).toList()}');
  }
}

List<Message> getMessages() => List.generate(
      100,
      (int i) => Message(
        uid: '${i + 1}',
        text: 'Message ${i + 1}',
        surveys: List.generate(
          5,
          (int i) => MessageSurvey(
            value: 'value ${i + 1}',
          ),
        ),
      ),
    );

List<Product> getProducts() => List.generate(
      100,
      (int i) => Product(
        uid: '${i + 1}',
        name: 'Product ${i + 1}',
      ),
    );

List<Order> getOrders() => List.generate(
      5,
      (int i) => Order(
        uid: '${i + 1}',
        number: '${i + 1}',

        ///
        products: List.generate(
          5,
          (int i) => ProductInOrder(
            uidProduct: '${i + 1}',
            nameProduct: 'Product ${i + 1}',

            ///
            exciseTaxs: List.generate(
              5,
              (int i) => ExciseTax(
                value: '${i + 1}',
              ),
            ),

            ///
            number: i + 1,
          ),
        ),
      ),
    );
