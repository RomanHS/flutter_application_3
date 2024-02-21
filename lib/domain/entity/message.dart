import 'package:flutter_application_3/domain/entity/entity.dart';
import 'package:flutter_application_3/domain/entity/message_text.dart';
import 'package:flutter_application_3/domain/enum/type_message.dart';
import 'package:flutter_application_3/domain/value/message_survey.dart';
import 'package:flutter_application_3/domain/value/settings_user.dart';

class Message extends Entity {
  final String text;
  final TypeMessage type;
  final List<MessageSurvey> surveys;
  final SettingsUser? settings;

  const Message({
    required super.uid,
    required this.text,
    required this.type,
    required this.surveys,
    required this.settings,
  });

  MessageText? get messageText {
    if (text.isEmpty) {
      return null;
    }

    return MessageText(
      uid: uid,
      text: text,
      type: type,
      surveys: surveys,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        text,
        type,
        surveys,
        settings,
      ];
}
