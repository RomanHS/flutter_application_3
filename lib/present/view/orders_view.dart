import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
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

    AppBar appBar() => AppBar(
          ///
          centerTitle: true,

          ///
          title: const Text('Orders'),

          ///
          // actions: [
          //   IconButton(
          //     onPressed: orders.isEmpty ? null : () => dataServis.transaction(ordersClear: true),
          //     icon: const Icon(Icons.delete),
          //   ),
          // ],
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
          child: const Icon(Icons.add),
          onPressed: () => dataServis.transaction(
            orders: [
              Order(
                uid: const Uuid().v4(),
                number: const Uuid().v4(),
                isConducted: false,

                ///
                products: List.generate(
                  10,
                  (int i) => ProductInOrder(
                    uidProduct: const Uuid().v4(),
                    nameProduct: 'Product ${i + 1}',
                    uidWarehaus: const Uuid().v4(),
                    number: i + 1,

                    ///
                    exciseTaxs: List.generate(
                      5,
                      (int i) => ExciseTax(
                        value: '${i + 1}',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

    return Scaffold(
      appBar: appBar(),
      body: body(),
      floatingActionButton: floatingActionButton(),
    );
  }
}
