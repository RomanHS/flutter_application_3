import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
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

  Order? get orderSave => dataServis.data.orders.get(_order.uid);

  bool get isSave => _order == orderSave;

  void setOrder(Order value) => setState(() => _order = value);

  @override
  Widget build(BuildContext context) {
    final Order order = _order;

    AppBar appBar() => AppBar();

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
