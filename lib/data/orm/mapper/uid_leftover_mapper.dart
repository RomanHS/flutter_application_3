import 'package:flutter_application_3/data/orm/entity/registr_entity.dart';
import 'package:flutter_application_3/domain/registr/leftover.dart';

extension UidLeftoverMapper on UidLeftover {
  // static UidLeftover fromDB(UidRegistrEntityDB uid) => UidLeftover(
  //       uidWarehaus: uid.get('uid_warehaus'),
  //       uidProduct: uid.get('uid_product'),
  //     );

  UidRegistrEntityDB toDB({
    required String uidUser,
  }) =>
      UidRegistrEntityDB(
        keys: {
          'uid_warehaus': uidWarehaus,
          'uid_product': uidProduct,
        }..removeWhere((String key, Object? value) => value != null),
      );
}
