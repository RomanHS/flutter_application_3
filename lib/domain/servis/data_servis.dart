import 'package:flutter_application_3/domain/data.dart';
import 'package:flutter_application_3/domain/entity/message.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/domain/repo/data_repo.dart';

class DataServis {
  final String uidUser;
  final DataRepo dataRepo;
  final Data data;

  DataServis({
    required this.uidUser,
    required this.dataRepo,
    required this.data,
  });

  Future<void> put({
    Iterable<Order>? orders,
    Iterable<Product>? products,
    Iterable<Message>? messages,
    Iterable<String>? ordersDelete,
    Iterable<String>? productsDelete,
    Iterable<String>? messagesDelete,
  }) async {
    await dataRepo.put(
      uidUser: uidUser,
      orders: orders,
      products: products,
      messages: messages,
      ordersDelete: ordersDelete,
      productsDelete: productsDelete,
      messagesDelete: messagesDelete,
    );

    ///

    if (orders != null) {
      data.orders.putAll(orders);
    }

    if (products != null) {
      data.products.putAll(products);
    }

    if (messages != null) {
      data.messages.putAll(messages);
    }

    ///

    if (ordersDelete != null) {
      data.orders.deleteAll(ordersDelete);
    }

    if (productsDelete != null) {
      data.products.deleteAll(productsDelete);
    }

    if (messagesDelete != null) {
      data.messages.deleteAll(messagesDelete);
    }
  }

  Future<void> dispose() => data.dispose();
}
