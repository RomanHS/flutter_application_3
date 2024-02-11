import 'package:flutter_application_3/data/orm/tables.dart';
import 'package:flutter_application_3/data/orm/tabular_part/tabular_part.dart';

class Entity {
  final TableHeader table;
  final Map<String, Object?> data;
  final Map<TableTab, List<TabularPart>> tabularParts;

  Entity({
    required this.table,
    required this.data,
    required this.tabularParts,
  });

  String get uid => data['uid'] as String;
}
