import 'package:equatable/equatable.dart';

abstract class RegistrEntity<TUidRegistr extends UidRegistr> {
  TUidRegistr get uid;
  Iterable<TUidRegistr> get uids;
}

abstract class UidRegistr extends Equatable {
  const UidRegistr();
}
