import 'package:flutter_application_3/domain/registr/leftover.dart';
import 'package:flutter_application_3/domain/store_registr.dart';

void testStoreRegistr() {
  final StoreRegistr<UidLeftover, Leftover> leftoverStoreRegistr = StoreRegistr(values: []);

  leftoverStoreRegistr.putAll(List.generate(5, (int i) => Leftover(uidProduct: 'Product', uidWarehouse: 'Warehaus ${i + 1}', value: i + 100)));

  final List<Leftover> leftovers = leftoverStoreRegistr.getList(const UidLeftover(uidProduct: 'Product', uidWarehaus: null)).toList();

  leftovers;

  leftoverStoreRegistr.deleteList(const UidLeftover(uidProduct: 'Product', uidWarehaus: null));

  final List<Leftover> list = leftoverStoreRegistr.values.toList();

  list;
}
