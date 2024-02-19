import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/store_value.dart';
import 'package:flutter_application_3/domain/value/settings.dart';

class Aut {
  final StoreValue<User> user;
  final StoreValue<Settings> settings;

  Aut({
    required User user,
    required Settings settings,
  })  : user = StoreValue<User>(value: user),
        settings = StoreValue<Settings>(value: settings);

  factory Aut.empty() => Aut(
        user: User.empty(),
        settings: Settings.empty(),
      );

  Future<void> dispose() async {
    await user.dispose();
    await settings.dispose();
  }
}
