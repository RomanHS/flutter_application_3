import 'dart:async';
import 'package:flutter_application_3/domain/registr/registr.dart';

class Store<TRegistrEntity extends RegistrEntity> {
  final Map<UidRegistr, TRegistrEntity> _map;
  final Map<UidRegistr, Map<UidRegistr, TRegistrEntity>> _mapList;

  late final StreamController<TRegistrEntity> _streamController = StreamController.broadcast();

  Store({
    required Iterable<TRegistrEntity> values,
  })  : _map = {},
        _mapList = {} {
    for (TRegistrEntity value in values) {
      _map[value.uid] = value;

      for (UidRegistr uid in value.uids) {
        _mapList.putIfAbsent(uid, () => {})[value.uid] = value;
      }
    }
  }

  Iterable<TRegistrEntity> get values => _map.values;

  Stream<TRegistrEntity> get stream => _streamController.stream;

  TRegistrEntity? get(UidRegistr uid) => _map[uid];

  Iterable<TRegistrEntity> getList(UidRegistr uid) => _mapList[uid]?.values ?? [];

  void put(TRegistrEntity value) {
    _map[value.uid] = value;

    for (UidRegistr uid in value.uids) {
      _mapList.putIfAbsent(uid, () => {})[value.uid] = value;
    }

    _streamController.add(value);
  }

  void putAll(Iterable<TRegistrEntity> values) {
    for (TRegistrEntity value in values) {
      put(value);
    }
  }

  void delete(UidRegistr uid) {
    final TRegistrEntity? value = _map.remove(uid);

    if (value != null) {
      for (UidRegistr uid in value.uids) {
        _mapList[uid]?.remove(value.uid);
      }

      _streamController.add(value);
    }
  }

  void deleteAll(Iterable<UidRegistr> uids) {
    for (UidRegistr uid in uids) {
      delete(uid);
    }
  }

  void clear() {
    for (TRegistrEntity value in values) {
      _streamController.add(value);
    }
    _map.clear();
  }

  Future<void> dispose() => _streamController.close();
}
