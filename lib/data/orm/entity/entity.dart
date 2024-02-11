import 'package:flutter_application_3/data/orm/tables.dart';
import 'package:flutter_application_3/data/orm/tabular_part/tabular_part.dart';

class Entity {
  final Map<String, Object?> data;
  final Map<TableTable, List<TabularPart>> tabularParts;

  Entity({
    required this.data,
    required this.tabularParts,
  });

  String get uid => data['uid'] as String;

  T get<T>(String key) => data[key] as T;

  List<TabularPart> getTabular(TableTable table) => tabularParts[table] ?? [];
}
