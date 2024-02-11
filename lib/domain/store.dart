import 'dart:async';
import 'package:flutter_application_3/domain/entity/entity.dart';

class Store<TEntity extends Entity> {
  final Map<String, TEntity> _map;

  late final StreamController<TEntity> _streamController = StreamController.broadcast();

  Store({
    required Iterable<TEntity> values,
  }) : _map = Map.fromEntries(values.map((e) => MapEntry(e.uid, e)));

  Iterable<TEntity> get values => _map.values;

  Stream<TEntity> get stream => _streamController.stream;

  void put(TEntity value) {
    _map[value.uid] = value;
    _streamController.add(value);
  }

  void putAll(Iterable<TEntity> values) {
    for (TEntity value in values) {
      put(value);
    }
  }

  void delete(String uid) {
    final TEntity? value = _map.remove(uid);

    if (value != null) {
      _streamController.add(value);
    }
  }

  void deleteAll(Iterable<String> uids) {
    for (String uid in uids) {
      delete(uid);
    }
  }

  void clear() {
    for (TEntity value in values) {
      _streamController.add(value);
    }
    _map.clear();
  }

  Future<void> dispose() => _streamController.close();
}
