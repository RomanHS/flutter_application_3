import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/domain/servis/order_servis.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';
import 'package:flutter_application_3/internal/di.dart';
import 'package:flutter_application_3/present/dialog/select_product_dialog.dart';
import 'package:flutter_application_3/present/dialog/negative_leftovers_dialog.dart';
import 'package:flutter_application_3/present/widget/product_in_order_widget.dart';

class OrderView extends StatefulWidget {
  final Order initOrder;

  const OrderView({
    super.key,
    required this.initOrder,
  });

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  late Order _order = widget.initOrder;

  StreamSubscription<Order>? _streamSubscription;

  Order? get orderSave => DI.i.dataServis.data.orders.get(_order.uid);

  bool get isSave => _order == orderSave;

  @override
  void initState() {
    _streamSubscription = DI.i.dataServis.data.orders.stream.where((Order o) => o.uid == _order.uid).listen(setOrder);
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void setOrder(Order value) => setState(() => _order = value);

  void putProductInOrder(ProductInOrder value) {
    final List<ProductInOrder> products = _order.products.toList();

    final int index = products.indexWhere((ProductInOrder p) => p.uidProduct == value.uidProduct);

    if (value.number > 0) {
      if (index != -1) {
        products[index] = value;
      }
      //
      else {
        products.add(value);
      }
    }
    //
    else {
      if (index != -1) {
        products.removeAt(index);
      }
    }

    setOrder(_order.copyWith(products: products));
  }

  @override
  Widget build(BuildContext context) {
    final Order order = _order;

    AppBar appBar() => AppBar(
          ///
          actions: [
            ///
            TextButton(
              onPressed: order.products.isEmpty
                  ? null
                  : () => OrderServis(DI.i.dataServis).conduct(
                        order,
                        () => NegativeLeftoversDialog.show(context),
                        DI.i.dataServis.data.settings.value.isNegativeLeftovers,
                      ),
              child: Text(order.isConducted ? 'Cancel conduct' : 'Conduct'),
            ),

            ///
            TextButton(
              onPressed: order.products.isEmpty || isSave ? null : () => DI.i.dataServis.transaction(orders: [order]),
              child: const Text('Save'),
            ),
          ],

          ///
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Row(
              children: [
                ///
                Expanded(
                  child: RadioListTile<bool>(
                    value: order.isReceipt,
                    groupValue: true,
                    onChanged: order.isConducted ? null : (bool? _) => setOrder(order.copyWith(isReceipt: true)),
                    title: const Text('Приход'),
                  ),
                ),

                ///
                Expanded(
                  child: RadioListTile<bool>(
                    value: !order.isReceipt,
                    groupValue: true,
                    onChanged: order.isConducted ? null : (bool? _) => setOrder(order.copyWith(isReceipt: false)),
                    title: const Text('Расход'),
                  ),
                ),
              ],
            ),
          ),
        );

    Widget body() {
      if (order.products.isEmpty) {
        return const Center(
          child: Text('Empty'),
        );
      }

      return ListView.builder(
        itemCount: order.products.length,
        itemBuilder: (BuildContext context, int i) {
          final ProductInOrder productInOrder = order.products[i];

          return ProductInOrderWidget(
            key: Key(productInOrder.uidProduct),
            productInOrder: productInOrder,
            putProductInOrder: order.isConducted ? null : putProductInOrder,
          );
        },
      );
    }

    Widget floatingActionButton() => FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            final Product? product = await SelectProductDialog.show(context);

            if (product == null) {
              return;
            }

            putProductInOrder(ProductInOrder(uidProduct: product.uid, nameProduct: product.name, uidWarehaus: '1', exciseTaxs: const [], number: 1));
          },
        );

    return Scaffold(
      appBar: appBar(),
      body: body(),
      floatingActionButton: order.isConducted ? null : floatingActionButton(),
    );
  }
}
