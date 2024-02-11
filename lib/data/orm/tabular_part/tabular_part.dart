class TabularPart {
  final Map<String, Object?> data;

  TabularPart({
    required this.data,
  });

  String get uidParent => data['uid_parent'] as String;
}
