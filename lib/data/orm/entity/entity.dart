import 'package:flutter_application_3/data/orm/entity/order.dart';

abstract class Entity {
  final String uidUser;
  final String uid;

  Entity({
    required this.uidUser,
    required this.uid,
  });

  static Iterable<String> creates() sync* {
    yield* OrderEntity.create();
  }

  static Iterable<String> getTables<TEntity extends Entity>() {
    if (TEntity == OrderEntity) {
      return OrderEntity.getTables();
    }

    throw TEntity;
  }

  static TEntity parse<TEntity extends Entity>(Map<String, Object?> json, Map<String, List<Map<String, Object?>>> tabularParts) {
    if (TEntity == OrderEntity) {
      return OrderEntity.from(json, tabularParts) as TEntity;
    }

    throw TEntity;
  }

  Map<String, Object?> to();

  Map<String, List<Map<String, Object?>>> toTabularParts();
}
