import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/orm/db.dart';
import 'package:flutter_application_3/data/repo/data_repo_impl.dart';
import 'package:flutter_application_3/domain/data.dart';
import 'package:flutter_application_3/domain/repo/data_repo.dart';
import 'package:flutter_application_3/domain/servis/data_servis.dart';
import 'package:flutter_application_3/present/app/app.dart';

late final DataServis dataServis;

void main() async {
  log('main');

  WidgetsFlutterBinding.ensureInitialized();

  final DB db = await DB.init();

  const String uidUser = '1';

  final DataRepo dataRepo = DataRepoImpl(db: db);

  final Data data = await dataRepo.get(uidUser: uidUser);

  dataServis = DataServis(uidUser: uidUser, dataRepo: dataRepo, data: data);

  runApp(const App());
}
