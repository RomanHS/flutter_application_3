enum TableHeader {
  orderTable,
}

enum TableTab {
  productsInOrderTable,
  exciseTaxInOrderTable,
}

extension TableHeaderExtension on TableHeader {
  Iterable<TableTab> get tabs => switch (this) {
        ///
        TableHeader.orderTable => [
            TableTab.productsInOrderTable,
            TableTab.exciseTaxInOrderTable,
          ]
      };

  Iterable<String> get createParams => switch (this) {
        ///
        TableHeader.orderTable => [
            'number TEXT',
          ],
      };
}

extension TableTabExtension on TableTab {
  Iterable<String> get createParams => switch (this) {
        ///
        TableTab.productsInOrderTable => [
            'uid_product TEXT',
            'name_product TEXT',
          ],

        ///
        TableTab.exciseTaxInOrderTable => [
            'uid_product TEXT',
            'value TEXT',
          ],
      };
}
