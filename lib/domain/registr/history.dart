import 'package:flutter_application_3/domain/registr/registr.dart';

class History extends RegistrEntity<UidHistory> {
  final String uidPoint;
  final String uidDocument;
  final String uidProduct;
  final DateTime date;
  final double number;

  History({
    required this.uidPoint,
    required this.uidDocument,
    required this.uidProduct,
    required this.date,
    required this.number,
  });

  @override
  UidHistory get uid => UidHistory(
        uidPoint: uidPoint,
        uidDocument: uidDocument,
        uidProduct: uidProduct,
        date: date,
      );

  @override
  Iterable<UidHistory> get uids => [
        UidHistory(
          uidPoint: uidPoint,
          uidDocument: null,
          uidProduct: null,
          date: null,
        ),
        UidHistory(
          uidPoint: uidPoint,
          uidDocument: null,
          uidProduct: uidProduct,
          date: null,
        ),
        UidHistory(
          uidPoint: uidPoint,
          uidDocument: null,
          uidProduct: null,
          date: date,
        ),
        UidHistory(
          uidPoint: null,
          uidDocument: null,
          uidProduct: uidProduct,
          date: date,
        ),
      ];
}

class UidHistory extends UidRegistr {
  final String? uidPoint;
  final String? uidDocument;
  final String? uidProduct;
  final DateTime? date;

  const UidHistory({
    required this.uidPoint,
    required this.uidDocument,
    required this.uidProduct,
    required this.date,
  });

  @override
  List<Object?> get props => [
        uidPoint,
        uidDocument,
        uidProduct,
        date,
      ];
}
