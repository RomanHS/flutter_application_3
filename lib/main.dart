import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/aut.dart';
import 'package:flutter_application_3/domain/servis/aut_servis.dart';
import 'package:flutter_application_3/internal/di.dart';
import 'package:flutter_application_3/present/app/app.dart';

late final AutServis autServis;

void main() async {
  log('main');

  WidgetsFlutterBinding.ensureInitialized();

  final DI di = await DI.init();

  final Aut aut = await di.autRepo.getAut();

  autServis = AutServis(
    autRepo: di.autRepo,
    aut: aut,
  );

  // await deleteRegistrsTest(db);

  runApp(const App());
}
