import 'package:flutter_application_3/domain/data.dart';
import 'package:flutter_application_3/domain/entity/message.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/domain/registr/leftover.dart';

abstract interface class DataLocal {
  Future<Data> get({
    required String uidUser,
  });

  Future<void> transaction({
    required String uidUser,
    required Iterable<Order>? orders,
    required Iterable<Product>? products,
    required Iterable<Message>? messages,
    required Iterable<Leftover>? leftovers,
    required Iterable<String>? ordersDelete,
    required Iterable<String>? productsDelete,
    required Iterable<String>? messagesDelete,
    required Iterable<UidLeftover>? leftoversDelete,
    required bool ordersClear,
    required bool productsClear,
    required bool messagesClear,
  });
}
