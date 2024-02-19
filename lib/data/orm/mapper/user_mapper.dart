import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/domain/entity/user.dart';

extension UserMapper on User {
  static User fromDB(EntityDB entity) => User(
        uid: entity.get('uid'),
        isAut: entity.get<int>('is_aut') != 0,
      );

  EntityDB toDB() => EntityDB(
        data: {
          'uid': uid,
          'is_aut': isAut ? 1 : 0,
        },
        tabularParts: {},
      );
}