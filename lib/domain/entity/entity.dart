import 'package:equatable/equatable.dart';

abstract class Entity extends Equatable {
  final String uid;

  const Entity({
    required this.uid,
  });
}
