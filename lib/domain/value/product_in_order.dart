import 'package:equatable/equatable.dart';
import 'package:flutter_application_3/domain/value/excise_tax.dart';

class ProductInOrder extends Equatable {
  final String uidProduct;
  final String nameProduct;
  final List<ExciseTax> exciseTaxs;
  final double number;

  const ProductInOrder({
    required this.uidProduct,
    required this.nameProduct,
    required this.exciseTaxs,
    required this.number,
  });

  @override
  List<Object?> get props => [
        uidProduct,
        nameProduct,
        exciseTaxs,
        number,
      ];
}
