import 'package:flutter_application_3/data/orm/entity/registr_entity.dart';
import 'package:flutter_application_3/domain/registr/leftover.dart';

extension LeftoverMapper on Leftover {
  static Leftover fromDB(RegistrEntityDB value) => Leftover(
        uidWarehouse: value.get('uid_warehouse'),
        uidProduct: value.get('uid_product'),
        value: value.get('value'),
      );

  RegistrEntityDB toDB({
    required String uidUser,
  }) =>
      RegistrEntityDB(
        data: {
          'uid_user': uidUser,
          'uid_warehouse': uidWarehouse,
          'uid_product': uidProduct,
          'value': value,
        },
      );
}
