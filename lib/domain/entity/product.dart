import 'package:flutter_application_3/domain/entity/entity.dart';

class Product extends Entity {
  final String name;

  const Product({
    required super.uid,
    required this.name,
  });

  @override
  List<Object?> get props => [
        uid,
        name,
      ];
}
