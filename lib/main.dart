import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/orm/db.dart';
import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/data/orm/mapper/message_mapper.dart';
import 'package:flutter_application_3/data/orm/mapper/order_mapper.dart';
import 'package:flutter_application_3/data/orm/mapper/product_mapper.dart';
import 'package:flutter_application_3/data/orm/tables.dart';
import 'package:flutter_application_3/data/repo/data_repo_impl.dart';
import 'package:flutter_application_3/domain/data.dart';
import 'package:flutter_application_3/domain/entity/message.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/domain/repo/data_repo.dart';
import 'package:flutter_application_3/domain/servis/data_servis.dart';
import 'package:flutter_application_3/domain/value/excise_tax.dart';
import 'package:flutter_application_3/domain/value/message_survey.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';

late final DataServis dataServis;

void main() async {
  /// init
  WidgetsFlutterBinding.ensureInitialized();

  log('main');

  final DB db = await DB.init();

  const String uidUser = '1';

  final DataRepo dataRepo = DataRepoImpl(db: db);

  final Data data = await dataRepo.get(uidUser: uidUser);

  dataServis = DataServis(
    uidUser: uidUser,
    dataRepo: dataRepo,
    data: data,
  );

  final List<Order> orders = getOrders();
  final List<Product> products = getProducts();
  final List<Message> messages = getMessages();

  /// put
  await db.putObjects<Order>(
    table: TableHeader.orderTable,
    uidUser: uidUser,
    objects: orders,
    parse: (Order o) => OrderMapper(o).toDB(uidUser: uidUser),
  );

  await db.putObjects<Product>(
    table: TableHeader.productTable,
    uidUser: uidUser,
    objects: products,
    parse: (Product p) => ProductMapper(p).toDB(uidUser: uidUser),
  );

  await db.putObjects<Message>(
    table: TableHeader.message,
    uidUser: uidUser,
    objects: messages,
    parse: (Message m) => MessageMapper(m).toDB(uidUser: uidUser),
  );

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
    await db.delete(
      table: TableHeader.orderTable,
      uidUser: uidUser,
      uids: ['2', '3'],
    );

    await db.delete(
      table: TableHeader.productTable,
      uidUser: uidUser,
      uids: null,
    );

    await db.delete(
      table: TableHeader.message,
      uidUser: uidUser,
      uids: null,
    );

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

  ///
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
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
          ),
        ),
      ),
    );
