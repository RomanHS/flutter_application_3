import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/store_value.dart';

class Aut {
  final StoreValue<User?> user;

  Aut({
    required User? user,
  }) : user = StoreValue<User?>(value: user);
}
