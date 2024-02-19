import 'package:flutter_application_3/data/local/data_local.dart';
import 'package:flutter_application_3/domain/data.dart';
import 'package:flutter_application_3/domain/entity/message.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/domain/registr/leftover.dart';
import 'package:flutter_application_3/domain/repo/data_repo.dart';
import 'package:flutter_application_3/domain/value/settings_user.dart';

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
    required SettingsUser? settings,
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
  }) =>
      dataLocal.transaction(
        uidUser: uidUser,
        settings: settings,
        orders: orders,
        products: products,
        messages: messages,
        leftovers: leftovers,
        ordersDelete: ordersDelete,
        productsDelete: productsDelete,
        messagesDelete: messagesDelete,
        leftoversDelete: leftoversDelete,
        ordersClear: ordersClear,
        productsClear: productsClear,
        messagesClear: messagesClear,
      );
}
