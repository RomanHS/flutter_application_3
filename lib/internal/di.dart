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

class DI {
  static late final DI i;

  final DB db;

  late final DataLocal dataLocal = DataLocalImpl(db: db);

  late final AutRepo autRepo = AutRepoImpl();
  late final DataRepo dataRepo = DataRepoImpl(dataLocal: dataLocal);

  late AutServis _autServis = AutServis(aut: Aut.empty(), autRepo: autRepo);
  late DataServis _dataServis = DataServis(user: User.empty(), data: Data.empty(), dataRepo: dataRepo);

  DI._({
    required this.db,
  });

  AutServis get autServis => _autServis;
  DataServis get dataServis => _dataServis;

  void setAutServis(AutServis autServis) {
    _autServis.dispose();
    _autServis = autServis;
  }

  void setDataServis(DataServis dataServis) {
    _dataServis.dispose();
    _dataServis = dataServis;
  }

  static Future<DI> init() async {
    final DB db = await DB.init();

    return i = DI._(
      db: db,
    );
  }
}
