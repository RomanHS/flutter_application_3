import 'package:flutter_application_3/domain/enum/type_message.dart';
import 'package:flutter_application_3/domain/registr/registr.dart';
import 'package:flutter_application_3/domain/value/message_survey.dart';

class MessageText extends RegistrEntity<UidMessageText> {
  final String uidMessage;
  final String text;
  final TypeMessage type;
  final bool isArchive;
  final List<MessageSurvey> surveys;

  MessageText({
    required this.uidMessage,
    required this.text,
    required this.type,
    required this.isArchive,
    required this.surveys,
  });

  @override
  UidMessageText get uid => UidMessageText(
        uidMessage: uidMessage,
        type: type,
        isArchive: isArchive,
      );

  @override
  Iterable<UidMessageText> get uids => [
        ///
        UidMessageText(
          uidMessage: null,
          type: null,
          isArchive: isArchive,
        ),

        ///
        UidMessageText(
          uidMessage: null,
          type: type,
          isArchive: isArchive,
        ),
      ];
}

class UidMessageText extends UidRegistr {
  final String? uidMessage;
  final TypeMessage? type;
  final bool? isArchive;

  const UidMessageText({
    required this.uidMessage,
    required this.type,
    required this.isArchive,
  });

  factory UidMessageText.empty() => const UidMessageText(uidMessage: null, type: null, isArchive: null);

  @override
  List<Object?> get props => [
        uidMessage,
        type,
        isArchive,
      ];
}
