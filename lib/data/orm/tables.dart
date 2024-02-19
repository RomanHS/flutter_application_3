enum TableHeader {
  userTable,
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
        TableHeader.userTable => [],

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
        TableHeader.userTable => [
            'uid TEXT',
            'is_aut INTEGER',
          ],

        ///
        TableHeader.orderTable => [
            'uid_user TEXT',
            'uid TEXT',
            'number TEXT',
            'is_conducted INTEGER',
            'is_receipt INTEGER',
          ],

        ///
        TableHeader.productTable => [
            'uid_user TEXT',
            'uid TEXT',
            'name TEXT',
          ],

        ///
        TableHeader.message => [
            'uid_user TEXT',
            'uid TEXT',
            'text TEXT',
          ],
      };
}

extension TableTableExtension on TableTable {
  Iterable<String> get createParams => switch (this) {
        ///
        TableTable.productsInOrderTable => [
            'uid_user TEXT',
            'uid_parent TEXT',
            'uid_product TEXT',
            'name_product TEXT',
            'uid_warehaus TEXT',
            'number REAL',
          ],

        ///
        TableTable.exciseTaxInOrderTable => [
            'uid_user TEXT',
            'uid_parent TEXT',
            'uid_product TEXT',
            'value TEXT',
          ],

        ///
        TableTable.messageSurvey => [
            'uid_user TEXT',
            'uid_parent TEXT',
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
