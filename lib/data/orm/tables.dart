enum TableHeader {
  orderTable,
}

enum TableTable {
  productsInOrderTable,
  exciseTaxInOrderTable,
}

extension TableHeaderExtension on TableHeader {
  Iterable<TableTable> get tables => switch (this) {
        ///
        TableHeader.orderTable => [
            TableTable.productsInOrderTable,
            TableTable.exciseTaxInOrderTable,
          ]
      };

  Iterable<String> get createParams => switch (this) {
        ///
        TableHeader.orderTable => [
            'number TEXT',
          ],
      };
}

extension TableTableExtension on TableTable {
  Iterable<String> get createParams => switch (this) {
        ///
        TableTable.productsInOrderTable => [
            'uid_product TEXT',
            'name_product TEXT',
          ],

        ///
        TableTable.exciseTaxInOrderTable => [
            'uid_product TEXT',
            'value TEXT',
          ],
      };
}
