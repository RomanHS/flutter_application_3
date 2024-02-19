import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/servis/order_servis.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';
import 'package:flutter_application_3/present/dialog/negative_leftovers_dialog.dart';
import 'package:flutter_application_3/present/view/home_view.dart';
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
                putProductInOrder: null,
              ),
            )
            .toList(),
      );
    }

    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceBetween,
      scrollable: true,
      content: content(),
      actions: [
        ///
        TextButton(
          onPressed: order.isConducted ? null : () => dataServis.transaction(ordersDelete: [uid]),
          child: const Text('Delete'),
        ),

        ///
        TextButton(
          onPressed: () => OrderServis(dataServis).conduct(order, () => NegativeLeftoversDialog.show(context)),
          child: Text(order.isConducted ? 'Cancel conduct' : 'Conduct'),
        ),

        ///
        // TextButton(
        //   onPressed: () => Navigator.pop(context),
        //   child: const Text('Ok'),
        // ),
      ],
    );
  }
}
