import 'package:flutter_application_3/domain/entity/message_text.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/domain/registr/leftover.dart';
import 'package:flutter_application_3/domain/store.dart';
import 'package:flutter_application_3/domain/store_registr.dart';
import 'package:flutter_application_3/domain/store_value.dart';
import 'package:flutter_application_3/domain/value/settings_user.dart';

class Data {
  final StoreValue<SettingsUser> settings;
  final Store<Order> orders;
  final Store<Product> products;
  final Store<MessageText> messages;
  final StoreRegistr<UidLeftover, Leftover> leftovers;

  Data({
    required SettingsUser settings,
    required Iterable<Order> orders,
    required Iterable<Product> products,
    required Iterable<MessageText> messages,
    required Iterable<Leftover> leftovers,
  })  : settings = StoreValue<SettingsUser>(value: settings),
        orders = Store<Order>(values: orders),
        products = Store<Product>(values: products),
        messages = Store<MessageText>(values: messages),
        leftovers = StoreRegistr<UidLeftover, Leftover>(values: leftovers);

  factory Data.empty() => Data(
        settings: SettingsUser.empty(),
        leftovers: [],
        messages: [],
        orders: [],
        products: [],
      );

  Future<void> dispose() async {
    await settings.dispose();
    await orders.dispose();
    await products.dispose();
    await messages.dispose();
    await leftovers.dispose();
  }
}
