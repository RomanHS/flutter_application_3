import 'package:flutter_application_3/domain/entity/document.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';

class Order extends Document {
  final String number;
  final List<ProductInOrder> products;
  final bool isReceipt;

  const Order({
    required super.uid,
    required super.isConducted,
    required this.number,
    required this.products,
    required this.isReceipt,
  });

  bool get isNotReceipt => !isReceipt;

  @override
  List<Object?> get props => [
        uid,
        isConducted,
        number,
        products,
        isReceipt,
      ];

  Order copyWith({
    String? uid,
    bool? isConducted,
    String? number,
    List<ProductInOrder>? products,
    bool? isReceipt,
  }) {
    return Order(
      uid: uid ?? this.uid,
      isConducted: isConducted ?? this.isConducted,
      number: number ?? this.number,
      products: products ?? this.products,
      isReceipt: isReceipt ?? this.isReceipt,
    );
  }
}
