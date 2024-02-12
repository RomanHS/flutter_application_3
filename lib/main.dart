import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/local/data_local.dart';
import 'package:flutter_application_3/data/local/data_local_impl.dart';
import 'package:flutter_application_3/data/orm/db.dart';
import 'package:flutter_application_3/data/repo/data_repo_impl.dart';
import 'package:flutter_application_3/domain/data.dart';
import 'package:flutter_application_3/domain/repo/data_repo.dart';
import 'package:flutter_application_3/domain/servis/data_servis.dart';
import 'package:flutter_application_3/present/app/app.dart';
import 'package:flutter_application_3/test_store_registr.dart';

late final DataServis dataServis;

void main() async {
  log('main');

  WidgetsFlutterBinding.ensureInitialized();

  final DB db = await DB.init();

  const String uidUser = '1';

  final DataLocal dataLocal = DataLocalImpl(db: db);

  final DataRepo dataRepo = DataRepoImpl(dataLocal: dataLocal);

  final Data data = await dataRepo.get(uidUser: uidUser);

  dataServis = DataServis(uidUser: uidUser, dataRepo: dataRepo, data: data);

  testStoreRegistr();

  runApp(const App());
}
