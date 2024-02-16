import 'package:flutter_application_3/domain/entity/entity.dart';

class User extends Entity {
  const User({
    required super.uid,
  });

  factory User.empty() => const User(uid: '');

  @override
  List<Object?> get props => [
        uid,
      ];
}
