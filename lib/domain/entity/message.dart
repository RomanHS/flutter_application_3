import 'package:flutter_application_3/domain/entity/entity.dart';
import 'package:flutter_application_3/domain/value/message_survey.dart';

class Message extends Entity {
  final String text;
  final List<MessageSurvey> surveys;

  const Message({
    required super.uid,
    required this.text,
    required this.surveys,
  });

  @override
  List<Object?> get props => [
        uid,
        text,
        surveys,
      ];
}
