import 'package:flutter_application_3/domain/entity/entity.dart';

abstract class Handbook extends Entity {
  final String name;

  const Handbook({
    required super.uid,
    required this.name,
  });
}
