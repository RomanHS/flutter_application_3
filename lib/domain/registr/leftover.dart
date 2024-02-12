import 'package:flutter_application_3/domain/registr/registr.dart';

class Leftover extends RegistrEntity<UidLeftover> {
  final String uidWarehaus;
  final String uidProduct;

  Leftover({
    required this.uidWarehaus,
    required this.uidProduct,
  });

  @override
  UidLeftover get uid => UidLeftover(
        uidWarehaus: uidWarehaus,
        uidProduct: uidProduct,
      );

  @override
  Iterable<UidLeftover> get uids => [
        UidLeftover(
          uidWarehaus: null,
          uidProduct: uidProduct,
        ),
      ];
}

class UidLeftover extends UidRegistr {
  final String? uidWarehaus;
  final String? uidProduct;

  UidLeftover({
    required this.uidWarehaus,
    required this.uidProduct,
  });

  @override
  List<Object?> get props => [
        uidWarehaus,
        uidProduct,
      ];
}
