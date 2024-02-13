enum TableHeader {
  orderTable,
  productTable,
  message,
}

enum TableTable {
  productsInOrderTable,
  exciseTaxInOrderTable,
  messageSurvey,
}

enum TableRegistr {
  leftover,
}

extension TableHeaderExtension on TableHeader {
  Iterable<TableTable> get tables => switch (this) {
        ///
        TableHeader.orderTable => [
            TableTable.productsInOrderTable,
            TableTable.exciseTaxInOrderTable,
          ],

        ///
        TableHeader.productTable => [],

        ///
        TableHeader.message => [
            TableTable.messageSurvey,
          ],
      };

  Iterable<String> get createParams => switch (this) {
        ///
        TableHeader.orderTable => [
            'number TEXT',
          ],

        ///
        TableHeader.productTable => [
            'name TEXT',
          ],

        ///
        TableHeader.message => [
            'text TEXT',
          ],
      };
}

extension TableTableExtension on TableTable {
  Iterable<String> get createParams => switch (this) {
        ///
        TableTable.productsInOrderTable => [
            'uid_product TEXT',
            'name_product TEXT',
            'uid_warehaus TEXT',
            'number REAL',
          ],

        ///
        TableTable.exciseTaxInOrderTable => [
            'uid_product TEXT',
            'value TEXT',
          ],

        ///
        TableTable.messageSurvey => [
            'value TEXT',
          ],
      };
}

extension TableRegistrExtension on TableRegistr {
  Iterable<String> get keys => switch (this) {
        ///
        TableRegistr.leftover => [
            'uid_product',
            'uid_warehouse',
          ],
      };

  Iterable<String> get createParams => switch (this) {
        ///
        TableRegistr.leftover => [
            'uid_product TEXT',
            'uid_warehouse TEXT',
            'value REAL',
          ],
      };
}
