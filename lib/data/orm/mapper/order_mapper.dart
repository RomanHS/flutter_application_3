import 'package:flutter_application_3/data/orm/entity/order.dart';
import 'package:flutter_application_3/data/orm/tabular_part/excise_tax.dart';
import 'package:flutter_application_3/data/orm/tabular_part/product_in_order.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/value/excise_tax.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';

extension OrderEntityMapper on OrderEntity {
  Order to() {
    final Map<String, List<ExciseTaxTabularPart>> exciseTaxsMap = {};

    for (ExciseTaxTabularPart e in exciseTaxs) {
      exciseTaxsMap.putIfAbsent(e.uidProduct, () => []).add(e);
    }

    return Order(
      ///
      uid: uid,
      number: number,

      ///
      products: products
          .map(
            (ProductInOrderTabularPart p) => ProductInOrder(
              uidProduct: p.uidProduct,
              nameProduct: p.nameProduct,
              exciseTaxs: exciseTaxsMap[p.uidProduct]?.map((ExciseTaxTabularPart e) => ExciseTax(value: e.value)).toList() ?? [],
            ),
          )
          .toList(),
    );
  }
}

extension OrderMapper on Order {
  OrderEntity to({
    required String uidUser,
  }) {
    return OrderEntity(
      ///
      uidUser: uidUser,
      uid: uid,
      number: number,

      ///
      products: products
          .map(
            (ProductInOrder e) => ProductInOrderTabularPart(
              uidUser: uidUser,
              uidParent: uid,
              uidProduct: e.uidProduct,
              nameProduct: e.nameProduct,
            ),
          )
          .toList(),

      ///
      exciseTaxs: products
          .expand(
            (ProductInOrder p) => p.exciseTaxs.map(
              (ExciseTax e) => ExciseTaxTabularPart(
                uidUser: uidUser,
                uidParent: uid,
                uidProduct: p.uidProduct,
                value: e.value,
              ),
            ),
          )
          .toList(),
    );
  }
}
