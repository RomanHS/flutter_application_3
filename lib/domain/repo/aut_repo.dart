import 'package:flutter_application_3/domain/entity/user.dart';

abstract interface class AutRepo {
  Future<User?> getAutUser();

  Future<User> logIn({
    required String login,
  });

  Future<void> logOut({
    required User user,
  });

  Future<void> transaction({
    required User? user,
    required String? uidUserDelete,
  });
}
