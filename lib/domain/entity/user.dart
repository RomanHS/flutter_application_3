import 'package:flutter_application_3/domain/entity/entity.dart';

class User extends Entity {
  final String login;
  final String token;

  const User({
    required super.uid,
    required this.login,
    required this.token,
  });

  factory User.empty() => const User(uid: '', login: '', token: '');

  bool get isAut => token.isNotEmpty;

  @override
  List<Object?> get props => [
        uid,
        isAut,
      ];

  User copyWith({
    String? uid,
    String? login,
    String? token,
  }) {
    return User(
      uid: uid ?? this.uid,
      login: login ?? this.login,
      token: token ?? this.token,
    );
  }
}
