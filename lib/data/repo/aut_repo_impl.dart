import 'package:flutter_application_3/data/local/aut_local.dart';
import 'package:flutter_application_3/domain/aut.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/repo/aut_repo.dart';
import 'package:flutter_application_3/domain/value/settings.dart';
import 'package:flutter_application_3/domain/value/settings_user.dart';
import 'package:flutter_application_3/domain/value/user_and_settings.dart';

class AutRepoImpl implements AutRepo {
  final AutLocal dataLocal;

  AutRepoImpl({
    required this.dataLocal,
  });

  @override
  Future<Aut> getAut() => dataLocal.getAut();

  @override
  Future<UserAndSettings> logIn({
    required String login,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return UserAndSettings(
      user: User(uid: login, login: login, token: login),
      settingsUser: const SettingsUser(isNegativeLeftovers: true),
    );
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
    required SettingsUser? settingsUser,
    required String? uidUserDelete,
  }) =>
      dataLocal.transaction(
        user: user,
        settings: settings,
        settingsUser: settingsUser,
        uidUserDelete: uidUserDelete,
      );
}
