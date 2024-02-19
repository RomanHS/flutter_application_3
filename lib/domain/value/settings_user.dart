class SettingsUser {
  final bool isNegativeLeftovers;

  const SettingsUser({
    required this.isNegativeLeftovers,
  });

  factory SettingsUser.empty() => const SettingsUser(isNegativeLeftovers: false);

  SettingsUser copyWith({
    bool? isNegativeLeftovers,
  }) {
    return SettingsUser(
      isNegativeLeftovers: isNegativeLeftovers ?? this.isNegativeLeftovers,
    );
  }
}
