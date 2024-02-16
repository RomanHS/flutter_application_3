import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/local/data_local.dart';
import 'package:flutter_application_3/data/local/data_local_impl.dart';
import 'package:flutter_application_3/data/orm/db.dart';
import 'package:flutter_application_3/data/repo/aut_repo_impl.dart';
import 'package:flutter_application_3/data/repo/data_repo_impl.dart';
import 'package:flutter_application_3/domain/aut.dart';
import 'package:flutter_application_3/domain/data.dart';
import 'package:flutter_application_3/domain/entity/user.dart';
import 'package:flutter_application_3/domain/repo/aut_repo.dart';
import 'package:flutter_application_3/domain/repo/data_repo.dart';
import 'package:flutter_application_3/domain/servis/aut_servis.dart';
import 'package:flutter_application_3/domain/servis/data_servis.dart';
import 'package:flutter_application_3/present/app/app.dart';

late final AutServis autServis;

late DataServis dataServis;

void main() async {
  log('main');

  WidgetsFlutterBinding.ensureInitialized();

  final DB db = await DB.init();

  final AutRepo autRepo = AutRepoImpl();

  final Aut aut = await autRepo.getAut();

  autServis = AutServis(autRepo: autRepo, aut: aut);

  final DataLocal dataLocal = DataLocalImpl(db: db);

  final DataRepo dataRepo = DataRepoImpl(dataLocal: dataLocal);

  final User user = aut.user.value ?? User.empty();

  final Data data = await dataRepo.get(uidUser: user.uid);

  dataServis = DataServis(user: user, dataRepo: dataRepo, data: data);

  // await deleteRegistrsTest(db);

  runApp(const App());
}
