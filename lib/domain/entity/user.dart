import 'package:flutter_application_3/domain/entity/entity.dart';

class User extends Entity {
  final String login;
  final bool isAut;

  const User({
    required super.uid,
    required this.login,
    required this.isAut,
  });

  factory User.empty() => const User(uid: '', login: '', isAut: false);

  @override
  List<Object?> get props => [
        uid,
        isAut,
      ];

  User copyWith({
    String? uid,
    String? login,
    bool? isAut,
  }) {
    return User(
      uid: uid ?? this.uid,
      login: login ?? this.login,
      isAut: isAut ?? this.isAut,
    );
  }
}
