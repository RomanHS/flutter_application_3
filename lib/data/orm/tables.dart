enum TableHeader {
  orderTable,
}

enum TableTab {
  productsInOrderTable,
  exciseTaxTable,
}

extension TableHeaderExtension on TableHeader {
  Iterable<TableTab> get tabs => switch (this) {
        ///
        TableHeader.orderTable => [
            TableTab.productsInOrderTable,
            TableTab.exciseTaxTable,
          ]
      };

  Iterable<String> createParams() => switch (this) {
        ///
        TableHeader.orderTable => [
            'number TEXT',
          ],
      };
}

extension TableTabExtension on TableTab {
  Iterable<String> createParams() => switch (this) {
        ///
        TableTab.productsInOrderTable => [
            'uid_product TEXT',
            'name_product TEXT',
          ],

        ///
        TableTab.exciseTaxTable => [
            'uid_product TEXT',
            'value TEXT',
          ],
      };
}
