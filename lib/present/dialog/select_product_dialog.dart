import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/entity/product.dart';
import 'package:flutter_application_3/internal/di.dart';
import 'package:flutter_application_3/present/widget/product_widget.dart';

class SelectProductDialog extends StatelessWidget {
  const SelectProductDialog._();

  static Future<Product?> show(BuildContext context) => showDialog<Product>(
        context: context,
        builder: (BuildContext context) => const SelectProductDialog._(),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: DI.i.dataServis.data.products.values
            .map(
              (Product product) => ProductWidget(
                product: product,
                click: () => Navigator.pop(context, product),
                isDelete: false,
              ),
            )
            .toList(),
      ),
    );
  }
}
