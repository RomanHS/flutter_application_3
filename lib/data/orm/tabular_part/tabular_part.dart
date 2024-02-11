abstract class TabularPart {
  final String uidUser;
  final String uidParent;

  TabularPart({
    required this.uidUser,
    required this.uidParent,
  });

  Map<String, Object?> to();
}
