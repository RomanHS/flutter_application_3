import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/domain/value/excise_tax.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/present/dialog/order_dialog.dart';
import 'package:uuid/uuid.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder<void>(
        stream: dataServis.data.orders.stream,
        builder: (BuildContext context, AsyncSnapshot<void> _) => _build(context),
      );

  Widget _build(BuildContext context) {
    final List<Order> orders = dataServis.data.orders.values.toList();
    final List<Order> ordersNotConducted = orders.where((Order o) => o.isNotConducted).toList();

    AppBar appBar() => AppBar(
          ///
          centerTitle: true,

          ///
          title: const Text('Orders'),

          ///
          actions: [
            IconButton(
              onPressed: ordersNotConducted.isEmpty
                  ? null
                  : () => dataServis.transaction(
                        ordersDelete: ordersNotConducted.map((Order o) => o.uid),
                      ),
              icon: const Icon(Icons.delete),
            ),
          ],
        );

    Widget body() {
      if (orders.isEmpty) {
        return const Center(
          child: Text('Empty'),
        );
      }

      return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int i) {
          final Order order = orders[i];

          return Card(
            key: Key(order.uid),
            child: ListTile(
              onTap: () => OrderDialog.show(context: context, uid: order.uid),
              title: Text(order.number),
              trailing: IconButton(
                onPressed: order.isConducted ? null : () => dataServis.transaction(ordersDelete: [order.uid]),
                icon: const Icon(Icons.delete),
              ),
            ),
          );
        },
      );
    }

    Widget floatingActionButton() => FloatingActionButton(
          onPressed: () => dataServis.transaction(
            orders: [
              Order(
                uid: const Uuid().v4(),
                number: (DateTime.now().millisecondsSinceEpoch ~/ 100).toString(),
                isConducted: false,

                ///
                products: dataServis.data.products.values
                    .map(
                      (Product p) => ProductInOrder(
                        uidProduct: p.uid,
                        nameProduct: p.name,
                        uidWarehaus: '1',
                        number: Faker().randomGenerator.integer(100, min: 2).toDouble(),

                        ///
                        exciseTaxs: List.generate(
                          5,
                          (int i) => ExciseTax(
                            value: '${i + 1}',
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          child: const Icon(Icons.add),
        );

    return Scaffold(
      appBar: appBar(),
      body: body(),
      floatingActionButton: dataServis.data.products.values.isEmpty ? null : floatingActionButton(),
    );
  }
}
