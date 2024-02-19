class Settings {
  final bool isDarkTheme;

  const Settings({
    required this.isDarkTheme,
  });

  factory Settings.empty() => const Settings(isDarkTheme: false);

  Settings copyWith({
    bool? isDarkTheme,
  }) {
    return Settings(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    );
  }
}
