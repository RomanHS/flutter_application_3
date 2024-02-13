import 'package:flutter_application_3/data/orm/entity/entity.dart';
import 'package:flutter_application_3/data/orm/tables.dart';
import 'package:flutter_application_3/data/orm/tabular_part/tabular_part.dart';
import 'package:flutter_application_3/domain/entity/order.dart';
import 'package:flutter_application_3/domain/value/excise_tax.dart';
import 'package:flutter_application_3/domain/value/product_in_order.dart';

extension OrderMapper on Order {
  static Order fromDB(EntityDB entity) {
    final Map<String, List<TabularPart>> exciseTaxsMap = {};

    for (TabularPart e in entity.getTabular(TableTable.exciseTaxInOrderTable)) {
      exciseTaxsMap.putIfAbsent(e.get('uid_product'), () => []).add(e);
    }

    return Order(
      ///
      uid: entity.uid,
      number: entity.get('number'),
      isConducted: entity.get<int>('is_conducted') != 0,
      isReceipt: entity.get<int>('is_receipt') != 0,

      ///
      products: (entity.getTabular(TableTable.productsInOrderTable))
          .map(
            (TabularPart p) => ProductInOrder(
              uidProduct: p.get('uid_product'),
              nameProduct: p.get('name_product'),
              uidWarehaus: p.get('uid_warehaus'),
              number: p.get('number'),
              exciseTaxs: exciseTaxsMap[p.get('uid_product')]
                      ?.map(
                        (TabularPart e) => ExciseTax(
                          value: e.get('value'),
                        ),
                      )
                      .toList() ??
                  [],
            ),
          )
          .toList(),
    );
  }

  EntityDB toDB({
    required String uidUser,
  }) {
    return EntityDB(
      ///
      data: {
        'uid_user': uidUser,
        'uid': uid,
        'number': number,
        'is_conducted': isConducted ? 1 : 0,
        'is_receipt': isReceipt ? 1 : 0,
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
                  'uid_warehaus': e.uidWarehaus,
                  'number': e.number,
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
