import 'package:flutter_application_3/domain/entity/entity.dart';

class User extends Entity {
  final bool isAut;

  const User({
    required super.uid,
    required this.isAut,
  });

  factory User.empty() => const User(uid: '', isAut: false);

  @override
  List<Object?> get props => [
        uid,
        isAut,
      ];

  User copyWith({
    String? uid,
    bool? isAut,
  }) {
    return User(
      uid: uid ?? this.uid,
      isAut: isAut ?? this.isAut,
    );
  }
}
