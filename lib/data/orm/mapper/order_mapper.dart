import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/data/orm/tables.dart';
import 'package:flutter_application_3/data/orm/tabular_part/tabular_part.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/value/excise_tax.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';

extension OrderMapper on Order {
  static Order fromDB(Entity entity) {
    final Map<String, List<TabularPart>> exciseTaxsMap = {};

    for (TabularPart e in entity.tabularParts[TableTable.exciseTaxInOrderTable] ?? []) {
      exciseTaxsMap.putIfAbsent(e.data['uid_product'] as String, () => []).add(e);
    }

    return Order(
      ///
      uid: entity.uid,
      number: entity.data['number'] as String,

      ///
      products: (entity.tabularParts[TableTable.productsInOrderTable] ?? [])
          .map(
            (TabularPart p) => ProductInOrder(
              uidProduct: p.data['uid_product'] as String,
              nameProduct: p.data['name_product'] as String,
              exciseTaxs: exciseTaxsMap[p.data['uid_product'] as String]
                      ?.map(
                        (TabularPart e) => ExciseTax(
                          value: e.data['value'] as String,
                        ),
                      )
                      .toList() ??
                  [],
            ),
          )
          .toList(),
    );
  }

  Entity toDB({
    required String uidUser,
  }) {
    return Entity(
      ///
      data: {
        'uid_user': uidUser,
        'uid': uid,
        'number': number,
      },

      ///
      tabularParts: {
        ///
        TableTable.productsInOrderTable: products
            .map(
              (ProductInOrder e) => TabularPart(
                data: {
                  'uid_user': uidUser,
                  'uid_parent': uid,
                  'uid_product': e.uidProduct,
                  'name_product': e.nameProduct,
                },
              ),
            )
            .toList(),

        ///
        TableTable.exciseTaxInOrderTable: products
            .expand(
              (ProductInOrder p) => p.exciseTaxs.map(
                (ExciseTax e) => TabularPart(
                  ///
                  data: {
                    'uid_user': uidUser,
                    'uid_parent': uid,
                    'uid_product': p.uidProduct,
                    'value': e.value,
                  },
                ),
              ),
            )
            .toList(),
      },
    );
  }
}
