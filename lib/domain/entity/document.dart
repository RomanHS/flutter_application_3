import 'package:equatable/equatable.dart';

abstract class Document extends Equatable {
  final String uid;

  const Document({
    required this.uid,
  });
}
