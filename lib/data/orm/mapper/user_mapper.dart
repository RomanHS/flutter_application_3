import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/domain/entity/user.dart';

extension UserMapper on User {
  static User fromDB(EntityDB entity) => User(
        uid: entity.get('uid'),
        login: entity.get('login'),
        token: entity.get('token'),
      );

  EntityDB toDB() => EntityDB(
        data: {
          'uid': uid,
          'login': login,
          'token': token,
        },
        tabularParts: {},
      );
}
