import 'package:flutter_application_3/domain/aut.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/value/settings.dart';

abstract interface class AutRepo {
  Future<Aut> getAut();

  Future<User> logIn({
    required String login,
  });

  Future<void> logOut({
    required User user,
  });

  Future<void> transaction({
    required User? user,
    required Settings? settings,
    required String? uidUserDelete,
  });
}
