import 'package:flutter_application_3/domain/entity/entity.dart';

abstract class Document extends Entity {
  final bool isConducted;

  const Document({
    required super.uid,
    required this.isConducted,
  });
}
