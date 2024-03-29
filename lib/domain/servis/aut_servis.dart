import 'package:flutter_application_3/domain/aut.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/repo/aut_repo.dart';
import 'package:flutter_application_3/domain/value/settings.dart';
import 'package:flutter_application_3/domain/value/user_and_settings.dart';

class AutServis {
  final AutRepo autRepo;
  final Aut aut;

  AutServis({
    required this.autRepo,
    required this.aut,
  });

  Future<void> logIn({
    required String login,
  }) async {
    final UserAndSettings userAndSettings = await autRepo.logIn(login: login);

    await autRepo.transaction(
      user: userAndSettings.user,
      settings: null,
      settingsUser: userAndSettings.settingsUser,
      uidUserDelete: null,
    );

    aut.user.put(userAndSettings.user);
    aut.users.put(userAndSettings.user);
  }

  Future<void> logOut({
    required User user,
  }) async {
    await autRepo.logOut(user: user);

    user = user.copyWith(token: '');

    await autRepo.transaction(
      user: user,
      settings: null,
      settingsUser: null,
      uidUserDelete: null,
    );

    aut.user.put(user);
    aut.users.put(user);
  }

  Future<void> putSettings({
    required Settings settings,
  }) async {
    await autRepo.transaction(
      user: null,
      settings: settings,
      settingsUser: null,
      uidUserDelete: null,
    );

    aut.settings.put(settings);
  }

  Future<void> deleteUser({
    required String uidUser,
  }) async {
    await autRepo.transaction(
      user: null,
      settings: null,
      settingsUser: null,
      uidUserDelete: uidUser,
    );

    aut.users.delete(uidUser);
  }

  Future<void> dispose() => aut.dispose();
}
