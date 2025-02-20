import 'package:flutter/foundation.dart';
import '../models/ItemModel/items_model.dart';
import '../data/local/datasources/item_data_source.dart';

class ItemRepo {
  final ItemDataSourceImpl _itemDataSource = ItemDataSourceImpl();

  Future<void> saveItem(ItemsModel item) async {
    try {
      await _itemDataSource.saveItem(item);
    } catch (e) {
      debugPrint("Error saving item: $e");
    }
  }

  Future<List<ItemsModel>> getAllItems() async {
    try {
      return await _itemDataSource.getAllItems();
    } catch (e) {
      debugPrint("Error fetching items: $e");
      return [];
    }
  }

  ItemsModel? getItem(int id) {
    try {
      return _itemDataSource.getItem(id);
    } catch (e) {
      debugPrint("Error fetching item: $e");
      return null;
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      await _itemDataSource.deleteItem(id);
    } catch (e) {
      debugPrint("Error deleting item: $e");
    }
  }

  Future<void> updateItem(ItemsModel item) async {
    try {
      await _itemDataSource.updateItem(item);
    } catch (e) {
      debugPrint("Error updating item: $e");
    }
  }
}
