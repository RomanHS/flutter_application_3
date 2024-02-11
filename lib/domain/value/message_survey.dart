import 'package:equatable/equatable.dart';

class MessageSurvey extends Equatable {
  final String value;

  const MessageSurvey({
    required this.value,
  });

  @override
  List<Object?> get props => [
        value,
      ];
}
