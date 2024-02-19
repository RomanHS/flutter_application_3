import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/value/settings_user.dart';

class UserAndSettings {
  final User user;
  final SettingsUser settingsUser;

  UserAndSettings({
    required this.user,
    required this.settingsUser,
  });
}
