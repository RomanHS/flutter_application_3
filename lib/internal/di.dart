import 'package:flutter_application_3/data/local/data_local.dart';
import 'package:flutter_application_3/data/local/data_local_impl.dart';
import 'package:flutter_application_3/data/orm/db.dart';
import 'package:flutter_application_3/data/repo/aut_repo_impl.dart';
import 'package:flutter_application_3/data/repo/data_repo_impl.dart';
import 'package:flutter_application_3/domain/repo/aut_repo.dart';
import 'package:flutter_application_3/domain/repo/data_repo.dart';

class DI {
  static late final DI instance;

  final DB db;

  late final DataLocal dataLocal = DataLocalImpl(db: db);

  late final AutRepo autRepo = AutRepoImpl();
  late final DataRepo dataRepo = DataRepoImpl(dataLocal: dataLocal);

  DI._({
    required this.db,
  });

  static Future<DI> init() async {
    final DB db = await DB.init();

    return instance = DI._(
      db: db,
    );
  }
}
