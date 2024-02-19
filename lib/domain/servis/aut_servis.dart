import 'package:flutter_application_3/domain/aut.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/repo/aut_repo.dart';
import 'package:flutter_application_3/domain/value/settings.dart';

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
    final User user = await autRepo.logIn(login: login);

    await autRepo.transaction(
      user: user,
      settings: null,
    );

    aut.user.put(user);
  }

  Future<void> logOut({
    required User user,
  }) async {
    await autRepo.logOut(user: user);

    user = user.copyWith(isAut: false);

    await autRepo.transaction(
      user: user,
      settings: null,
    );

    aut.user.put(user);
  }

  Future<void> putSettings({
    required Settings settings,
  }) async {
    await autRepo.transaction(
      user: null,
      settings: settings,
    );

    aut.settings.put(settings);
  }

  Future<void> dispose() => aut.dispose();
}
