import 'package:flutter_application_3/data/local/aut_local.dart';
import 'package:flutter_application_3/domain/aut.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/repo/aut_repo.dart';
import 'package:flutter_application_3/domain/value/settings.dart';

class AutRepoImpl implements AutRepo {
  final AutLocal dataLocal;

  AutRepoImpl({
    required this.dataLocal,
  });

  @override
  Future<Aut> getAut() => dataLocal.getAut();

  @override
  Future<User> logIn({
    required String login,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    return User(uid: login, login: login, isAut: true);
  }

  @override
  Future<void> logOut({
    required User user,
  }) async {
    // await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> transaction({
    required User? user,
    required Settings? settings,
    required String? uidUserDelete,
  }) =>
      dataLocal.transaction(
        user: user,
        settings: settings,
        uidUserDelete: uidUserDelete,
      );
}
