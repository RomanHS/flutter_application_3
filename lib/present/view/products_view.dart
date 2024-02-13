import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/present/widget/product_widget.dart';
import 'package:uuid/uuid.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

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
          title: const Text('Products'),

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

          return ProductWidget(
            key: Key(product.uid),
            product: product,
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
                name: Faker().food.dish(),
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
