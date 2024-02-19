import 'package:flutter_application_3/data/orm/db.dart';

sealed class DBValue {}

class DBMouk extends DBValue {}

class DBORM extends DBValue {
  final DB db;

  DBORM({
    required this.db,
  });
}
