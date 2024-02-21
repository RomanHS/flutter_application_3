import 'dart:async';

class StoreSimple<T> {
  final Set<T> _set;

  late final StreamController<T> _streamController = StreamController.broadcast();

  StoreSimple({
    required Iterable<T> values,
  }) : _set = values.toSet();

  Iterable<T> get values => _set;

  Stream<T> get stream => _streamController.stream;

  bool isContains(T value) => _set.contains(value);

  bool isNotContains(T value) => !_set.contains(value);

  void put(T value) {
    _set.add(value);
    _streamController.add(value);
  }

  void putAll(Iterable<T> values) {
    for (T value in values) {
      put(value);
    }
  }

  void delete(T value) {
    if (_set.remove(value)) {
      _streamController.add(value);
    }
  }

  void deleteAll(Iterable<T> values) {
    for (T value in values) {
      delete(value);
    }
  }

  void clear() {
    for (T value in values) {
      _streamController.add(value);
    }
    _set.clear();
  }

  Future<void> dispose() => _streamController.close();
}
