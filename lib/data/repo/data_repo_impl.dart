import 'package:flutter_application_3/data/local/data_local.dart';
import 'package:flutter_application_3/domain/data.dart';
import 'package:flutter_application_3/domain/entity/message.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/domain/repo/data_repo.dart';

class DataRepoImpl implements DataRepo {
  final DataLocal dataLocal;

  DataRepoImpl({
    required this.dataLocal,
  });

  @override
  Future<Data> get({
    required String uidUser,
  }) =>
      dataLocal.get(uidUser: uidUser);

  @override
  Future<void> transaction({
    required String uidUser,
    required Iterable<Order>? orders,
    required Iterable<Product>? products,
    required Iterable<Message>? messages,
    required Iterable<String>? ordersDelete,
    required Iterable<String>? productsDelete,
    required Iterable<String>? messagesDelete,
    required bool ordersClear,
    required bool productsClear,
    required bool messagesClear,
  }) =>
      dataLocal.transaction(
        uidUser: uidUser,
        orders: orders,
        products: products,
        messages: messages,
        ordersDelete: ordersDelete,
        productsDelete: productsDelete,
        messagesDelete: messagesDelete,
        ordersClear: ordersClear,
        productsClear: productsClear,
        messagesClear: messagesClear,
      );
}
