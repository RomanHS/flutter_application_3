import 'package:flutter_application_3/domain/aut.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/repo/aut_repo.dart';

class AutRepoImpl implements AutRepo {
  @override
  Future<Aut> getAut() async => Aut.empty();

  @override
  Future<User> logIn({
    required String login,
  }) async =>
      User(uid: login);

  @override
  Future<void> logOut({
    required User user,
  }) async {}

  @override
  Future<void> transaction({
    required User? user,
    required String? uidUserDelete,
  }) async {}
}
