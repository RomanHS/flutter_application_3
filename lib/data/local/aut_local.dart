import 'package:flutter_application_3/domain/aut.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/value/settings.dart';

abstract interface class AutLocal {
  Future<Aut> getAut();

  Future<void> transaction({
    required User? user,
    required Settings? settings,
    required String? uidUserDelete,
  });
}
