enum TableHeader {
  userTable,
  settingsTable,
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
        TableHeader.settingsTable => [],

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

  bool get isUserKey => switch (this) {
        TableHeader.userTable => false,
        TableHeader.settingsTable => false,
        TableHeader.orderTable => true,
        TableHeader.productTable => true,
        TableHeader.message => true,
      };

  Iterable<String> get createParams => switch (this) {
        ///
        TableHeader.userTable => [
            'login TEXT',
            'is_aut INTEGER',
          ],

        ///
        TableHeader.settingsTable => [
            'is_dark_theme INTEGER',
          ],

        ///
        TableHeader.orderTable => [
            'number TEXT',
            'is_conducted INTEGER',
            'is_receipt INTEGER',
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
  bool get isUserKey => switch (this) {
        TableTable.productsInOrderTable => true,
        TableTable.exciseTaxInOrderTable => true,
        TableTable.messageSurvey => true,
      };

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
