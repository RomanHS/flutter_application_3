import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/orm/db.dart';
import 'package:flutter_application_3/data/repo/data_repo_impl.dart';
import 'package:flutter_application_3/domain/data.dart';
import 'package:flutter_application_3/domain/repo/data_repo.dart';
import 'package:flutter_application_3/domain/servis/data_servis.dart';

late final DataServis dataServis;

void main() async {
  /// init
  WidgetsFlutterBinding.ensureInitialized();

  log('main');

  final DB db = await DB.init();

  const String uidUser = '1';

  final DataRepo dataRepo = DataRepoImpl(db: db);

  final Data data = await dataRepo.get(uidUser: uidUser);

  dataServis = DataServis(uidUser: uidUser, dataRepo: dataRepo, data: data);

  ///
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
