import 'package:flutter_application_3/domain/entity/document.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';

class Order extends Document {
  final String number;
  final List<ProductInOrder> products;

  const Order({
    required super.uid,
    required this.number,
    required this.products,
  });

  @override
  List<Object?> get props => [
        uid,
        number,
        products,
      ];
}
