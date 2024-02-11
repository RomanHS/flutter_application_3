import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/main.dart';
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
            child: ListTile(
              title: Text(product.name),
            ),
          );
        },
      );
    }

    Widget floatingActionButton() => FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => dataServis.put(
            products: [
              Product(
                uid: const Uuid().v4(),
                name: const Uuid().v4(),
              ),
            ],
          ),
        );

    return Scaffold(
      body: body(),
      floatingActionButton: floatingActionButton(),
    );
  }
}