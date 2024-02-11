import 'package:flutter_application_3/data/orm/tables.dart';
import 'package:flutter_application_3/data/orm/tabular_part/tabular_part.dart';

class Entity {
  final TableHeader table;
  final String uidUser;
  final String uid;
  final Map<String, Object?> data;
  final Map<TableTab, List<TabularPart>> tabularParts;

  Entity({
    required this.table,
    required this.uidUser,
    required this.uid,
    required this.data,
    required this.tabularParts,
  });
}
