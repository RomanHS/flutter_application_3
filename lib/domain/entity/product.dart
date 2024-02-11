import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String uid;
  final String name;

  const Product({
    required this.uid,
    required this.name,
  });

  @override
  List<Object?> get props => [
        uid,
        name,
      ];
}
