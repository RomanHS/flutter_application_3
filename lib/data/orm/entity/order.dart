import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/data/orm/tabular_part/excise_tax.dart';
import 'package:flutter_application_3/data/orm/tabular_part/product_in_order.dart';

class OrderEntity extends Entity {
  final String number;
  final List<ProductInOrderTabularPart> products;
  final List<ExciseTaxTabularPart> exciseTaxs;

  OrderEntity({
    required super.uidUser,
    required super.uid,
    required this.number,
    required this.products,
    required this.exciseTaxs,
  });

  static Iterable<String> create() sync* {
    yield 'CREATE TABLE OrderEntity (uid_user TEXT, uid TEXT, number TEXT)';
    yield ProductInOrderTabularPart.create();
    yield ExciseTaxTabularPart.create();
  }

  static Iterable<String> getTables() sync* {
    yield 'ProductInOrderTabularPart';
    yield 'ExciseTaxTabularPart';
  }

  static OrderEntity from(Map<String, Object?> json, Map<String, List<Map<String, Object?>>> tabularParts) => OrderEntity(
        uidUser: json['uid_user'] as String,
        uid: json['uid'] as String,
        number: json['number'] as String,
        products: tabularParts['ProductInOrderTabularPart']?.map((e) => ProductInOrderTabularPart.from(e)).toList() ?? [],
        exciseTaxs: tabularParts['ExciseTaxTabularPart']?.map((e) => ExciseTaxTabularPart.from(e)).toList() ?? [],
      );

  @override
  Map<String, Object?> to() => {
        'uid_user': uidUser,
        'uid': uid,
        'number': number,
      };

  @override
  Map<String, List<Map<String, Object?>>> toTabularParts() => {
        'ProductInOrderTabularPart': products.map((e) => e.to()).toList(),
        'ExciseTaxTabularPart': exciseTaxs.map((e) => e.to()).toList(),
      };
}
