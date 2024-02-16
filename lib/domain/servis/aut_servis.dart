import 'package:flutter_application_3/domain/aut.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/repo/aut_repo.dart';
import 'package:flutter_application_3/domain/repo/data_repo.dart';

class AutServis {
  final AutRepo autRepo;
  final DataRepo dataRepo;
  final Aut aut;

  AutServis({
    required this.autRepo,
    required this.dataRepo,
    required this.aut,
  });

  Future<void> logIn({
    required String login,
  }) async {
    final User user = await autRepo.logIn(login: login);

    await autRepo.transaction(
      user: user,
      uidUserDelete: null,
    );

    aut.user.put(user);
  }

  Future<void> logOut({
    required User user,
  }) async {
    await autRepo.logOut(user: user);

    await autRepo.transaction(
      user: null,
      uidUserDelete: user.uid,
    );

    aut.user.put(null);
  }
}
