import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/registr/leftover.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';
import 'package:flutter_application_3/main.dart';

class ProductInOrderWidget extends StatelessWidget {
  final ProductInOrder productInOrder;

  const ProductInOrderWidget({
    super.key,
    required this.productInOrder,
  });

  @override
  Widget build(BuildContext context) => StreamBuilder<void>(
        stream: dataServis.data.leftovers.stream.where((Leftover l) => l.uidProduct == productInOrder.uidProduct),
        builder: (BuildContext context, AsyncSnapshot<void> _) => _build(context),
      );

  Widget _build(BuildContext context) {
    final double leftover = dataServis.data.leftovers
            .get(
              UidLeftover(
                uidProduct: productInOrder.uidProduct,
                uidWarehaus: productInOrder.uidWarehaus,
              ),
            )
            ?.value ??
        0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ///
            const SizedBox(width: double.maxFinite),

            ///
            Text(productInOrder.nameProduct),

            ///
            const SizedBox(height: 10),

            ///
            Text('Кількість: ${productInOrder.number.toStringAsFixed(3)}'),

            ///
            const SizedBox(height: 10),

            ///
            Text('Залишок: ${leftover.toStringAsFixed(3)}'),
          ],
        ),
      ),
    );
  }
}
