import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/aut.dart';
import 'package:flutter_application_3/domain/servis/aut_servis.dart';
import 'package:flutter_application_3/internal/di.dart';
import 'package:flutter_application_3/internal/enum/db_type.dart';
import 'package:flutter_application_3/present/app/app.dart';

void main() async {
  log('main');

  WidgetsFlutterBinding.ensureInitialized();

  final DI di = await DI.init(dBType: DBType.mouk);

  final Aut aut = await di.autRepo.getAut();

  di.autServis = AutServis(
    autRepo: di.autRepo,
    aut: aut,
  );

  // await deleteRegistrsTest(db);

  runApp(const App());
}
