import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/store.dart';
import 'package:flutter_application_3/domain/store_value.dart';
import 'package:flutter_application_3/domain/value/settings.dart';

class Aut {
  final StoreValue<User> user;
  final Store<User> users;
  final StoreValue<Settings> settings;

  Aut({
    required User user,
    required Iterable<User> users,
    required Settings settings,
  })  : user = StoreValue<User>(value: user),
        users = Store<User>(values: users),
        settings = StoreValue<Settings>(value: settings);

  factory Aut.empty() => Aut(
        user: User.empty(),
        users: [],
        settings: Settings.empty(),
      );

  Future<void> dispose() async {
    await user.dispose();
    await users.dispose();
    await settings.dispose();
  }
}
