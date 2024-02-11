import 'package:equatable/equatable.dart';
import 'package:flutter_application_3/domain/value/message_survey.dart';

class Message extends Equatable {
  final String uid;
  final String text;
  final List<MessageSurvey> surveys;

  const Message({
    required this.uid,
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
