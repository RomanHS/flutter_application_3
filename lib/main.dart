import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/local/data_local.dart';
import 'package:flutter_application_3/data/local/data_local_impl.dart';
import 'package:flutter_application_3/data/orm/db.dart';
import 'package:flutter_application_3/data/repo/aut_repo_impl.dart';
import 'package:flutter_application_3/data/repo/data_repo_impl.dart';
import 'package:flutter_application_3/domain/aut.dart';
import 'package:flutter_application_3/domain/repo/aut_repo.dart';
import 'package:flutter_application_3/domain/repo/data_repo.dart';
import 'package:flutter_application_3/domain/servis/aut_servis.dart';
import 'package:flutter_application_3/present/app/app.dart';

late final AutServis autServis;

void main() async {
  log('main');

  WidgetsFlutterBinding.ensureInitialized();

  final DB db = await DB.init();

  final DataLocal dataLocal = DataLocalImpl(db: db);

  final AutRepo autRepo = AutRepoImpl();

  final DataRepo dataRepo = DataRepoImpl(dataLocal: dataLocal);

  final Aut aut = await autRepo.getAut();

  autServis = AutServis(
    autRepo: autRepo,
    dataRepo: dataRepo,
    aut: aut,
  );

  // await deleteRegistrsTest(db);

  runApp(const App());
}
