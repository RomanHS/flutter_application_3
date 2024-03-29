import 'package:flutter_application_3/domain/entity/handbook.dart';

class Product extends Handbook {
  const Product({
    required super.uid,
    required super.name,
  });

  @override
  List<Object?> get props => [
        uid,
        name,
      ];
}
