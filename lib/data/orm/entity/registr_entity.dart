class RegistrEntityDB {
  final Map<String, Object?> data;

  RegistrEntityDB({
    required this.data,
  });

  T get<T>(String key) => data[key] as T;
}

class UidRegistrEntityDB {
  final Map<String, Object?> keys;

  UidRegistrEntityDB({
    required this.keys,
  });

  // T? get<T>(String key) => keys[key] as T?;
}
