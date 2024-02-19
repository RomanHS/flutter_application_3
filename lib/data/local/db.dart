import 'package:flutter_application_3/data/orm/db.dart';

sealed class DBValue {
  T when<T>({
    required T Function(DBMouk value) mouk,
    required T Function(DBORM value) orm,
  }) {
    final DBValue value = this;

    return switch (value) {
      DBMouk() => mouk(value),
      DBORM() => orm(value),
    };
  }
}

class DBMouk extends DBValue {}

class DBORM extends DBValue {
  final DB db;

  DBORM({
    required this.db,
  });
}
