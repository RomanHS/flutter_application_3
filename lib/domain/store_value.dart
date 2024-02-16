import 'dart:async';
import 'package:flutter_application_3/domain/entity/entity.dart';

class StoreValue<TEntity extends Entity?> {
  TEntity _value;

  late final StreamController<TEntity> _streamController = StreamController.broadcast();

  StoreValue({
    required TEntity value,
  }) : _value = value;

  TEntity get value => _value;

  void put(TEntity value) {
    _value = value;
    _streamController.add(value);
  }

  Future<void> dispose() => _streamController.close();
}
