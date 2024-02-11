import 'package:flutter_application_3/data/orm/tabular_part/tabular_part.dart';

class ExciseTaxTabularPart extends TabularPart {
  final String uidProduct;
  final String value;

  ExciseTaxTabularPart({
    required super.uidUser,
    required super.uidParent,
    required this.uidProduct,
    required this.value,
  });

  static String create() => 'CREATE TABLE ExciseTaxTabularPart (uid_user TEXT, uid_parent TEXT, uid_product TEXT, value TEXT)';

  static ExciseTaxTabularPart from(Map<String, Object?> json) => ExciseTaxTabularPart(
        uidUser: json['uid_user'] as String,
        uidParent: json['uid_parent'] as String,
        uidProduct: json['uid_product'] as String,
        value: json['value'] as String,
      );

  @override
  Map<String, Object?> to() => {
        'uid_user': uidUser,
        'uid_parent': uidParent,
        'uid_product': uidProduct,
        'value': value,
      };
}
