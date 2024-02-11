import 'package:flutter_application_3/domain/value/excise_tax.dart';

class ProductInOrder {
  final String uidProduct;
  final String nameProduct;
  final List<ExciseTax> exciseTaxs;

  ProductInOrder({
    required this.uidProduct,
    required this.nameProduct,
    required this.exciseTaxs,
  });
}
