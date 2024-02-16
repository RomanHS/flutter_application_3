import 'dart:async';

class StoreValue<T> {
  T _value;

  late final StreamController<T> _streamController = StreamController.broadcast();

  StoreValue({
    required T value,
  }) : _value = value;

  T get value => _value;

  void put(T value) {
    _value = value;
    _streamController.add(value);
  }

  Future<void> dispose() => _streamController.close();
}
