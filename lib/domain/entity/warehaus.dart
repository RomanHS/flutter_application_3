import 'package:flutter_application_3/domain/entity/handbook.dart';

class Warehaus extends Handbook {
  const Warehaus({
    required super.uid,
    required super.name,
  });

  @override
  List<Object?> get props => [
        uid,
        name,
      ];
}
