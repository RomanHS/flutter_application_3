import 'package:flutter/material.dart';
import 'package:flutter_application_3/present/view/orders_view.dart';
import 'package:flutter_application_3/present/view/products_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      appBar: AppBar(
        ///
        centerTitle: true,

        ///
        title: const Text('Home'),
      ),

      ///
      body: Column(
        children: [
          ///
          Card(
            child: ListTile(
              title: const Text('Products'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ProductsView(),
                ),
              ),
            ),
          ),

          ///
          Card(
            child: ListTile(
              title: const Text('Orders'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const OrdersView(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
