import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/servis/order_servis.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/present/widget/product_in_order_widget.dart';

class OrderView extends StatefulWidget {
  final Order initOrder;

  const OrderView({
    super.key,
    required this.initOrder,
  });

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  late Order _order = widget.initOrder;

  StreamSubscription<Order>? _streamSubscription;

  Order? get orderSave => dataServis.data.orders.get(_order.uid);

  bool get isSave => _order == orderSave;

  @override
  void initState() {
    _streamSubscription = dataServis.data.orders.stream.where((Order o) => o.uid == _order.uid).listen(setOrder);
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void setOrder(Order value) => setState(() => _order = value);

  void putProductInOrder(ProductInOrder value) {}

  @override
  Widget build(BuildContext context) {
    final Order order = _order;

    AppBar appBar() => AppBar(
          actions: [
            ///
            TextButton(
              onPressed: () => OrderServis(dataServis).conduct(order),
              child: Text(order.isConducted ? 'Cancel conduct' : 'Conduct'),
            ),

            ///
            TextButton(
              onPressed: isSave ? null : () => dataServis.transaction(orders: [order]),
              child: const Text('Save'),
            ),
          ],
        );

    Widget body() {
      if (order.products.isEmpty) {
        return const Center(
          child: Text('Empty'),
        );
      }

      return ListView.builder(
        itemCount: order.products.length,
        itemBuilder: (BuildContext context, int i) {
          final ProductInOrder productInOrder = order.products[i];

          return ProductInOrderWidget(
            key: Key(productInOrder.uidProduct),
            productInOrder: productInOrder,
            putProductInOrder: order.isConducted ? null : putProductInOrder,
          );
        },
      );
    }

    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }
}
