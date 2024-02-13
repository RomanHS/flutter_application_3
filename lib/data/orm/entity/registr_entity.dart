class RegistrEntityDB {
  // final Map<String, Object?> keys;
  final Map<String, Object?> data;

  RegistrEntityDB({
    // required this.keys,
    required this.data,
  });

  T get<T>(String key) => data[key] as T;
}
