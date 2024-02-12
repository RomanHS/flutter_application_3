import 'package:flutter_application_3/domain/registr/leftover.dart';
import 'package:flutter_application_3/domain/store_registr.dart';

void testStoreRegistr() {
  final StoreRegistr<UidLeftover, Leftover> leftoverStoreRegistr = StoreRegistr(values: []);

  leftoverStoreRegistr.putAll(List.generate(5, (int i) => Leftover(uidProduct: 'Product', uidWarehaus: 'Warehaus ${i + 1}')));

  final List<Leftover> leftovers = leftoverStoreRegistr.getList(UidLeftover(uidProduct: 'Product', uidWarehaus: null)).toList();

  leftovers;
}
