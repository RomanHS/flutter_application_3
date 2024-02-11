import 'package:flutter_application_3/domain/entity/message.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/domain/store.dart';

class Data {
  final Store<Order> orders;
  final Store<Product> products;
  final Store<Message> messages;

  Data({
    required Iterable<Order> orders,
    required Iterable<Product> products,
    required Iterable<Message> messages,
  })  : orders = Store<Order>(values: orders),
        products = Store<Product>(values: products),
        messages = Store<Message>(values: messages);

  Future<void> dispose() async {
    await orders.dispose();
    await products.dispose();
    await messages.dispose();
  }
}
