import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/registr/leftover.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/present/widget/product_in_order_widget.dart';

class OrderDialog extends StatelessWidget {
  final String uid;

  const OrderDialog._({
    required this.uid,
  });

  static Future<void> show({
    required BuildContext context,
    required String uid,
  }) =>
      showDialog<void>(
        context: context,
        builder: (BuildContext context) => OrderDialog._(uid: uid),
      );

  void conduct(Order order) async {
    final List<Leftover> leftovers = [];

    for (ProductInOrder productInOrder in order.products) {
      final double leftover = dataServis.data.leftovers.get(UidLeftover(uidProduct: productInOrder.uidProduct, uidWarehaus: '1'))?.value ?? 0;
      final double number = productInOrder.number;

      leftovers.add(
        Leftover(
          uidProduct: productInOrder.uidProduct,
          uidWarehouse: '1',
          value: order.isConducted ? leftover - number : leftover + number,
        ),
      );
    }

    await dataServis.transaction(
      leftovers: leftovers,
    );
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<void>(
        stream: dataServis.data.orders.stream.where((Order o) => o.uid == uid),
        builder: (BuildContext context, AsyncSnapshot<void> _) => _build(context),
      );

  Widget _build(BuildContext context) {
    final Order? order = dataServis.data.orders.get(uid);

    if (order == null) {
      return AlertDialog(
        key: const Key('Order not found'),
        title: const Text('Order not found'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Ok'),
          ),
        ],
      );
    }

    Widget content() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: order.products
            .map(
              (ProductInOrder productInOrder) => ProductInOrderWidget(
                productInOrder: productInOrder,
              ),
            )
            .toList(),
      );
    }

    return AlertDialog(
      scrollable: true,
      content: content(),
      actions: [
        ///
        TextButton(
          onPressed: () => conduct(order),
          child: Text(order.isConducted ? 'Cancel conduct' : 'Conduct'),
        ),

        ///
        TextButton(
          onPressed: () => dataServis.transaction(ordersDelete: [uid]),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
