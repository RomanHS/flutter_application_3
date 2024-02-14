import 'package:flutter_application_3/data/orm/entity/registr_entity.dart';
import 'package:flutter_application_3/domain/registr/leftover.dart';

extension UidLeftoverMapper on UidLeftover {
  UidRegistrEntityDB toDB({
    required String uidUser,
  }) =>
      UidRegistrEntityDB(
        keys: {
          'uid_warehouse': uidWarehouse,
          'uid_product': uidProduct,
        },
      );
}
