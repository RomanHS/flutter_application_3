import 'package:flutter_application_3/domain/aut.dart';
import 'package:flutter_application_3/domain/repo/aut_repo.dart';

class AutServis {
  final AutRepo autRepo;
  final Aut aut;

  AutServis({
    required this.autRepo,
    required this.aut,
  });
}
