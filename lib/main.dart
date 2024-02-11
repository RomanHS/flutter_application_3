import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/orm/db.dart';
import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/data/orm/mapper/order_mapper.dart';
import 'package:flutter_application_3/data/orm/tables.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/value/excise_tax.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';

void main() async {
  /// init
  WidgetsFlutterBinding.ensureInitialized();

  log('main');

  final DB db = await DB.init();

  const String uidUser = '1';

  final List<Order> orders = getOrders();

  /// put
  await db.putObjects<Order>(
    objects: orders,
    parse: (Order o) => OrderMapper(o).toDB(uidUser: uidUser),
  );

  /// get
  final List<Order> ordersDB = await db.getObjects<Order>(
    table: TableHeader.orderTable,
    uidUser: uidUser,
    uids: null,
    parse: (Entity e) => OrderMapper.fromDB(e),
  );

  /// equals
  final bool isEquals = listEquals(orders, ordersDB);

  log('orders:   ${orders.map((Order o) => o.uid).toList()}');
  log('ordersDB: ${ordersDB.map((Order o) => o.uid).toList()}');

  log('isEquals: $isEquals');

  /// delete
  {
    await db.delete(
      table: TableHeader.orderTable,
      uidUser: uidUser,
      uids: ['2', '3'],
    );

    final List<Order> ordersDB = await db.getObjects<Order>(
      table: TableHeader.orderTable,
      uidUser: uidUser,
      uids: null,
      parse: (Entity e) => OrderMapper.fromDB(e),
    );

    log('delete:   ${ordersDB.map((Order o) => o.uid).toList()}');
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
