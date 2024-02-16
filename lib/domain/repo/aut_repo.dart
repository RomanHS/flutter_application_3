import 'package:flutter_application_3/domain/entity/user.dart';

abstract interface class AutRepo {
  Future<User?> getAutUser();
}
