import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/domain/value/settings.dart';

extension SettingsMapper on Settings {
  static Settings fromDB(EntityDB entity) => Settings(
        // uid: entity.get('uid'),
        isDarkTheme: entity.get<int>('is_dark_theme') != 0,
      );

  EntityDB toDB() => EntityDB(
        data: {
          'uid': '',
          'is_dark_theme': isDarkTheme ? 1 : 0,
        },
        tabularParts: {},
      );
}
