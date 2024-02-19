import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/domain/value/settings_user.dart';

extension SettingsUserMapper on SettingsUser {
  static SettingsUser fromDB(EntityDB entity) => SettingsUser(
        isNegativeLeftovers: entity.get<int>('is_negative_leftovers') != 0,
      );

  EntityDB toDB({
    required String uidUser,
  }) =>
      EntityDB(
        data: {
          'uid_user': uidUser,
          'uid': '',
          'is_negative_leftovers': isNegativeLeftovers ? 1 : 0,
        },
        tabularParts: {},
      );
}
