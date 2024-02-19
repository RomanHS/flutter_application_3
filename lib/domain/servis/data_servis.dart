import 'package:flutter_application_3/domain/data.dart';
import 'package:flutter_application_3/domain/entity/message.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/registr/leftover.dart';
import 'package:flutter_application_3/domain/repo/data_repo.dart';
import 'package:flutter_application_3/domain/value/settings_user.dart';

class DataServis {
  final User user;
  final DataRepo dataRepo;
  final Data data;

  DataServis({
    required this.user,
    required this.dataRepo,
    required this.data,
  });

  Future<void> transaction({
    SettingsUser? settings,
    Iterable<Order>? orders,
    Iterable<Product>? products,
    Iterable<MessageText>? messages,
    Iterable<Leftover>? leftovers,
    Iterable<String>? ordersDelete,
    Iterable<String>? productsDelete,
    Iterable<String>? messagesDelete,
    Iterable<UidLeftover>? leftoversDelete,
    bool ordersClear = false,
    bool productsClear = false,
    bool messagesClear = false,
  }) async {
    await dataRepo.transaction(
      uidUser: user.uid,
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

    /// Clear

    if (ordersClear) {
      data.orders.clear();
    }

    if (productsClear) {
      data.products.clear();
    }

    if (messagesClear) {
      data.messages.clear();
    }

    /// Delete

    if (ordersDelete != null) {
      data.orders.deleteAll(ordersDelete);
    }

    if (productsDelete != null) {
      data.products.deleteAll(productsDelete);
    }

    if (messagesDelete != null) {
      data.messages.deleteAll(messagesDelete);
    }

    if (leftoversDelete != null) {
      data.leftovers.deleteAll(leftoversDelete);
    }

    /// Put

    if (settings != null) {
      data.settings.put(settings);
    }

    if (orders != null) {
      data.orders.putAll(orders);
    }

    if (products != null) {
      data.products.putAll(products);
    }

    if (messages != null) {
      data.messages.putAll(messages);
    }

    if (leftovers != null) {
      data.leftovers.putAll(leftovers);
    }
  }

  Future<void> dispose() => data.dispose();
}
