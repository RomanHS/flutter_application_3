import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/domain/registr/leftover.dart';
import 'package:flutter_application_3/main.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) => StreamBuilder<void>(
        stream: dataServis.data.leftovers.stream.where((Leftover l) => l.uidProduct == product.uid),
        builder: (BuildContext context, AsyncSnapshot<void> _) => _build(context),
      );

  Widget _build(BuildContext context) {
    final double leftover = dataServis.data.leftovers
            .get(
              UidLeftover(
                uidProduct: product.uid,
                uidWarehaus: '1',
              ),
            )
            ?.value ??
        0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ///
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ///
                  Text(product.name),

                  ///
                  const SizedBox(height: 10),

                  ///
                  Text('Залишок: ${leftover.toStringAsFixed(3)}'),
                ],
              ),
            ),

            ///
            IconButton(
              onPressed: () => dataServis.transaction(productsDelete: [product.uid]),
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
