import 'package:flutter_application_3/domain/data.dart';
import 'package:flutter_application_3/domain/entity/message.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/entity/product.dart';

abstract interface class DataRepo {
  Future<Data> get({
    required String uidUser,
  });

  Future<void> put({
    required String uidUser,
    Iterable<Order>? orders,
    Iterable<Product>? products,
    Iterable<Message>? messages,
  });
}
