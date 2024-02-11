import 'package:equatable/equatable.dart';

class ExciseTax extends Equatable {
  final String value;

  const ExciseTax({
    required this.value,
  });

  @override
  List<Object?> get props => [
        value,
      ];
}
