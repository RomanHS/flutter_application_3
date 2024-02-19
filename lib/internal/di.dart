import 'package:flutter_application_3/data/local/aut_local.dart';
import 'package:flutter_application_3/data/local/db.dart';
import 'package:flutter_application_3/data/orm/local/aut_local_orm.dart';
import 'package:flutter_application_3/data/local/data_local.dart';
import 'package:flutter_application_3/data/orm/local/data_local_orm.dart';
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
import 'package:flutter_application_3/internal/enum/db_type.dart';

class DI {
  static late final DI i;

  final DBValue db;

  late final AutLocal autLocal = db.when(mouk: (DBMouk db) => AutLocalMouk(), orm: (DBORM db) => AutLocalOrm(db: db.db));
  late final DataLocal dataLocal = db.when(mouk: (DBMouk db) => DataLocalMouk(), orm: (DBORM db) => DataLocalOrm(db: db.db));

  late final AutRepo autRepo = AutRepoImpl(dataLocal: autLocal);
  late final DataRepo dataRepo = DataRepoImpl(dataLocal: dataLocal);

  late AutServis _autServis = AutServis(aut: Aut.empty(), autRepo: autRepo);
  late DataServis _dataServis = DataServis(user: User.empty(), data: Data.empty(), dataRepo: dataRepo);

  DI._({
    required this.db,
  });

  AutServis get autServis => _autServis;
  DataServis get dataServis => _dataServis;

  set autServis(AutServis autServis) {
    _autServis.dispose();
    _autServis = autServis;
  }

  set dataServis(DataServis dataServis) {
    _dataServis.dispose();
    _dataServis = dataServis;
  }

  static Future<DI> init({
    required DBType dBType,
  }) async {
    final DBValue db = switch (dBType) {
      DBType.mouk => DBMouk(),
      DBType.orm => DBORM(db: await DB.init()),
    };

    return i = DI._(
      db: db,
    );
  }
}
