import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/registr/leftover.dart';
import 'package:flutter_application_3/domain/servis/data_servis.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';

extension OrderServis on DataServis {
  Future<void> conduct(Order order, Future<void> Function() onNegativeLeftovers) {
    final List<Leftover> leftovers = [];

    for (ProductInOrder productInOrder in order.products) {
      final UidLeftover uidLeftover = UidLeftover(
        uidProduct: productInOrder.uidProduct,
        uidWarehaus: productInOrder.uidWarehaus,
      );

      final double leftover = data.leftovers.get(uidLeftover)?.value ?? 0;

      double number = productInOrder.number;

      if (order.isNotReceipt) {
        number *= -1;
      }

      if (order.isConducted) {
        number *= -1;
      }

      leftovers.add(
        Leftover(
          uidProduct: productInOrder.uidProduct,
          uidWarehouse: productInOrder.uidWarehaus,
          value: leftover + number,
        ),
      );
    }

    for (Leftover leftover in leftovers) {
      if (leftover.value < 0) {
        return onNegativeLeftovers();
      }
    }

    return transaction(
      orders: [order.copyWith(isConducted: !order.isConducted)],
      leftovers: leftovers,
    );
  }
}
