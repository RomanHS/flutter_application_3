import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/orm/db.dart';
import 'package:flutter_application_3/data/orm/entity/order.dart';
import 'package:flutter_application_3/data/orm/mapper/order_mapper.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  log('main');

  final DB db = await DB.init();

  const String uidUser = '1';

  final Order o = Order(
    uid: '1',
    number: '1',
    products: List.generate(
      5,
      (int i) => ProductInOrder(
        uidProduct: '${i + 1}',
        nameProduct: 'Product ${i + 1}',
        exciseTaxs: [],
      ),
    ),
  );

  await db.put(entity: OrderMapper(o).to(uidUser: uidUser));

  final List<OrderEntity> ordersEntitys = await db.getAllSql<OrderEntity>(uidUser: uidUser, uids: null);

  final List<Order> orders = ordersEntitys.map((e) => OrderEntityMapper(e).to()).toList();

  orders;

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
