import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';
import 'package:flutter_application_3/main.dart';

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

  @override
  Widget build(BuildContext context) => StreamBuilder<void>(
        stream: dataServis.data.orders.stream.where((Order o) => o.uid == uid),
        builder: (BuildContext context, AsyncSnapshot<void> _) => _build(context),
      );

  Widget _build(BuildContext context) {
    final Order? order = dataServis.data.orders.get(uid);

    if (order == null) {
      return AlertDialog(
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
              (ProductInOrder p) => Card(
                child: ListTile(
                  title: Text(p.nameProduct),
                ),
              ),
            )
            .toList(),
      );
    }

    return AlertDialog(
      scrollable: true,
      content: content(),
      actions: [
        TextButton(
          onPressed: () => dataServis.transaction(ordersDelete: [uid]),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
