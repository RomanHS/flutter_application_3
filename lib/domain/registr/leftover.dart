import 'package:flutter_application_3/domain/registr/registr.dart';

class Leftover extends RegistrEntity<UidLeftover> {
  final String uidWarehouse;
  final String uidProduct;
  final double value;

  Leftover({
    required this.uidWarehouse,
    required this.uidProduct,
    required this.value,
  });

  @override
  UidLeftover get uid => UidLeftover(
        uidWarehouse: uidWarehouse,
        uidProduct: uidProduct,
      );

  @override
  Iterable<UidLeftover> get uids => [
        UidLeftover(
          uidWarehouse: null,
          uidProduct: uidProduct,
        ),
      ];
}

class UidLeftover extends UidRegistr {
  final String? uidWarehouse;
  final String? uidProduct;

  const UidLeftover({
    required this.uidWarehouse,
    required this.uidProduct,
  });

  @override
  List<Object?> get props => [
        uidWarehouse,
        uidProduct,
      ];
}
