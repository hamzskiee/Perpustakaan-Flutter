import 'item.dart';
import 'package:flutter_application_3/data/initial_data.dart';

class PerpustakaanService {
  static final PerpustakaanService _instance = PerpustakaanService._internal();

  factory PerpustakaanService() {
    return _instance;
  }

  PerpustakaanService._internal();

  final List<Item> koleksiItem = InitialData.getInitialItems();

  void tambahItem(Item item) {
    koleksiItem.add(item);
  }

  void hapusItem(Item item) {
    koleksiItem.remove(item);
  }

  void updateItem(Item oldItem, Item newItem) {
    final index = koleksiItem.indexOf(oldItem);
    if (index != -1) {
      koleksiItem[index] = newItem;
    }
  }

  Item? readItem(String judul) {
    try {
      return koleksiItem.firstWhere(
        (item) => item.judul.toLowerCase() == judul.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }
}
