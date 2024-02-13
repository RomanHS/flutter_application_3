import 'package:equatable/equatable.dart';
import 'package:flutter_application_3/domain/value/excise_tax.dart';

class ProductInOrder extends Equatable {
  final String uidProduct;
  final String nameProduct;
  final String uidWarehaus;
  final List<ExciseTax> exciseTaxs;
  final double number;

  const ProductInOrder({
    required this.uidProduct,
    required this.nameProduct,
    required this.uidWarehaus,
    required this.exciseTaxs,
    required this.number,
  });

  @override
  List<Object?> get props => [
        uidProduct,
        nameProduct,
        uidWarehaus,
        exciseTaxs,
        number,
      ];

  ProductInOrder copyWith({
    String? uidProduct,
    String? nameProduct,
    String? uidWarehaus,
    List<ExciseTax>? exciseTaxs,
    double? number,
  }) {
    return ProductInOrder(
      uidProduct: uidProduct ?? this.uidProduct,
      nameProduct: nameProduct ?? this.nameProduct,
      uidWarehaus: uidWarehaus ?? this.uidWarehaus,
      exciseTaxs: exciseTaxs ?? this.exciseTaxs,
      number: number ?? this.number,
    );
  }
}
