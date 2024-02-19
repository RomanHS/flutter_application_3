import 'package:flutter_application_3/domain/entity/entity.dart';
import 'package:flutter_application_3/domain/value/message_survey.dart';
import 'package:flutter_application_3/domain/value/settings_user.dart';

class Message extends Entity {
  final String text;
  final List<MessageSurvey> surveys;
  final SettingsUser? settings;

  const Message({
    required super.uid,
    required this.text,
    required this.surveys,
    required this.settings,
  });

  @override
  List<Object?> get props => [
        uid,
        text,
        surveys,
        settings,
      ];
}
