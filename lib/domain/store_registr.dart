import 'dart:async';
import 'package:flutter_application_3/domain/registr/registr.dart';

class StoreRegistr<TUidRegistr extends UidRegistr, TRegistrEntity extends RegistrEntity<TUidRegistr>> {
  final Map<TUidRegistr, TRegistrEntity> _map;
  final Map<TUidRegistr, Map<TUidRegistr, TRegistrEntity>> _mapList;

  late final StreamController<TRegistrEntity> _streamController = StreamController.broadcast();

  StoreRegistr({
    required Iterable<TRegistrEntity> values,
  })  : _map = {},
        _mapList = {} {
    for (TRegistrEntity value in values) {
      _map[value.uid] = value;

      for (TUidRegistr uid in value.uids) {
        _mapList.putIfAbsent(uid, () => {})[value.uid] = value;
      }
    }
  }

  Iterable<TRegistrEntity> get values => _map.values;

  Stream<TRegistrEntity> get stream => _streamController.stream;

  TRegistrEntity? get(TUidRegistr uid) => _map[uid];

  Iterable<TRegistrEntity> getList(TUidRegistr uid) => _mapList[uid]?.values ?? const [];

  int getListLength(TUidRegistr uid) => _mapList[uid]?.length ?? 0;

  void put(TRegistrEntity value) {
    _map[value.uid] = value;

    for (TUidRegistr uid in value.uids) {
      _mapList.putIfAbsent(uid, () => {})[value.uid] = value;
    }

    _streamController.add(value);
  }

  void putAll(Iterable<TRegistrEntity> values) {
    for (TRegistrEntity value in values) {
      put(value);
    }
  }

  void delete(TUidRegistr uid) {
    final TRegistrEntity? value = _map.remove(uid);

    if (value != null) {
      for (TUidRegistr uid in value.uids) {
        _mapList[uid]?.remove(value.uid);
      }

      _streamController.add(value);
    }

    for (TRegistrEntity value in _mapList.remove(uid)?.values ?? const []) {
      _map.remove(value.uid);

      _streamController.add(value);
    }
  }

  void deleteAll(Iterable<TUidRegistr> uids) {
    for (TUidRegistr uid in uids) {
      delete(uid);
    }
  }

  void clear() {
    for (TRegistrEntity value in values) {
      _streamController.add(value);
    }

    _map.clear();

    _mapList.clear();
  }

  Future<void> dispose() => _streamController.close();
}
