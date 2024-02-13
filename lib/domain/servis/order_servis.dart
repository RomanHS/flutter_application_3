import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/registr/leftover.dart';
import 'package:flutter_application_3/domain/servis/data_servis.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';

extension OrderServis on DataServis {
  Future<void> conduct(Order order) {
    final List<Leftover> leftovers = [];

    for (ProductInOrder productInOrder in order.products) {
      final UidLeftover uidLeftover = UidLeftover(
        uidProduct: productInOrder.uidProduct,
        uidWarehaus: productInOrder.uidWarehaus,
      );

      final double leftover = data.leftovers.get(uidLeftover)?.value ?? 0;

      final double number = productInOrder.number;

      leftovers.add(
        Leftover(
          uidProduct: productInOrder.uidProduct,
          uidWarehouse: productInOrder.uidWarehaus,
          value: order.isConducted ? leftover - number : leftover + number,
        ),
      );
    }

    return transaction(
      orders: [order.copyWith(isConducted: !order.isConducted)],
      leftovers: leftovers,
    );
  }
}
