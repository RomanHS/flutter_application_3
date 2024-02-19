import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/data/orm/tables.dart';
import 'package:flutter_application_3/data/orm/tabular_part/tabular_part.dart';
import 'package:flutter_application_3/domain/entity/message_text.dart';
import 'package:flutter_application_3/domain/value/message_survey.dart';

extension MessageMapper on MessageText {
  static MessageText fromDB(EntityDB entity) => MessageText(
        uid: entity.get('uid'),
        text: entity.get('text'),
        surveys: entity
            .getTabular(TableTable.messageSurvey)
            .map(
              (TabularPart e) => MessageSurvey(
                value: e.get('value'),
              ),
            )
            .toList(),
      );

  EntityDB toDB({
    required String uidUser,
  }) =>
      EntityDB(
        ///
        data: {
          'uid_user': uidUser,
          'uid': uid,
          'text': text,
        },

        ///
        tabularParts: {
          TableTable.messageSurvey: surveys
              .map(
                (MessageSurvey e) => TabularPart(
                  data: {
                    'uid_user': uidUser,
                    'uid_parent': uid,
                    'value': e.value,
                  },
                ),
              )
              .toList(),
        },
      );
}
