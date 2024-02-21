import 'package:flutter_application_3/data/orm/entity/registr_entity.dart';
import 'package:flutter_application_3/domain/registr/message_text.dart';
import 'package:flutter_application_3/domain/enum/type_message.dart';

extension MessageMapper on MessageText {
  static MessageText fromDB(RegistrEntityDB entity) => MessageText(
        uidMessage: entity.get('uid_message'),
        text: entity.get('text'),
        type: TypeMessage.values.byName(entity.get('type')),
        isArchive: entity.get<int>('is_archive') != 0,
        surveys: [],
      );

  RegistrEntityDB toDB({
    required String uidUser,
  }) =>
      RegistrEntityDB(
        ///
        data: {
          'uid_user': uidUser,
          'uid_message': uidMessage,
          'is_archive': isArchive ? 1 : 0,
          'text': text,
          'type': type.name,
        },
      );
}
