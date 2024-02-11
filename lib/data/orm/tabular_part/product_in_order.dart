import 'package:flutter_application_3/data/orm/tabular_part/tabular_part.dart';

class ProductInOrderTabularPart extends TabularPart {
  final String uidProduct;
  final String nameProduct;

  ProductInOrderTabularPart({
    required super.uidUser,
    required super.uidParent,
    required this.uidProduct,
    required this.nameProduct,
  });

  static String create() => 'CREATE TABLE ProductInOrderTabularPart (uid_user TEXT, uid_parent TEXT, uid_product TEXT, name_product TEXT)';

  static ProductInOrderTabularPart from(Map<String, Object?> json) => ProductInOrderTabularPart(
        uidUser: json['uid_user'] as String,
        uidParent: json['uid_parent'] as String,
        uidProduct: json['uid_product'] as String,
        nameProduct: json['name_product'] as String,
      );

  @override
  Map<String, Object?> to() => {
        'uid_user': uidUser,
        'uid_parent': uidParent,
        'uid_product': uidProduct,
        'name_product': nameProduct,
      };
}
