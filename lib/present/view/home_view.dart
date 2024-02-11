import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/present/view/orders_view.dart';
import 'package:uuid/uuid.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder<void>(
        stream: dataServis.data.products.stream,
        builder: (BuildContext context, AsyncSnapshot<void> _) => _build(context),
      );

  Widget _build(BuildContext context) {
    final List<Product> products = dataServis.data.products.values.toList();

    AppBar appBar() => AppBar(
          ///
          centerTitle: true,

          ///
          title: const Text('Home'),

          ///
          leading: IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const OrdersView(),
              ),
            ),
            icon: const Icon(Icons.money_off_csred_sharp),
          ),

          ///
          actions: [
            IconButton(
              onPressed: products.isEmpty ? null : () => dataServis.transaction(productsClear: true),
              icon: const Icon(Icons.delete),
            ),
          ],
        );

    Widget body() {
      if (products.isEmpty) {
        return const Center(
          child: Text('Empty'),
        );
      }

      return ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int i) {
          final Product product = products[i];

          return Card(
            key: Key(product.uid),
            child: ListTile(
              title: Text(product.name),
              trailing: IconButton(
                onPressed: () => dataServis.transaction(productsDelete: [product.uid]),
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
            products: [
              Product(
                uid: const Uuid().v4(),
                name: const Uuid().v4(),
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
