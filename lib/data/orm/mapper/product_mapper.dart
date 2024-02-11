import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/domain/entity/product.dart';

extension ProductMapper on Product {
  static Product fromDB(Entity entity) => Product(
        uid: entity.get('uid'),
        name: entity.get('name'),
      );

  Entity toDB({
    required String uidUser,
  }) =>
      Entity(
        data: {
          'uid_user': uidUser,
          'uid': uid,
          'name': name,
        },
        tabularParts: {},
      );
}
