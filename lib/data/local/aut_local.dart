import 'package:flutter_application_3/domain/aut.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/value/settings.dart';
import 'package:flutter_application_3/domain/value/settings_user.dart';

abstract interface class AutLocal {
  Future<Aut> getAut();

  Future<void> transaction({
    required User? user,
    required Settings? settings,
    required SettingsUser? settingsUser,
    required String? uidUserDelete,
  });
}

class AutLocalMouk implements AutLocal {
  @override
  Future<Aut> getAut() async => Aut.empty();

  @override
  Future<void> transaction({
    required User? user,
    required Settings? settings,
    required SettingsUser? settingsUser,
    required String? uidUserDelete,
  }) async {}
}
