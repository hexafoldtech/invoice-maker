import 'package:flutter/material.dart';
import '../models/ItemModel/items_model.dart';
import '../repository/items_repo.dart';

class ItemProvider extends ChangeNotifier {
  final ItemRepo _itemRepo = ItemRepo();
  List<ItemsModel> _items = [];

  List<ItemsModel> get items => _items;

  Future<void> fetchAllItems() async {
    _items = await _itemRepo.getAllItems();
    notifyListeners();
  }

  Future<void> addItem(ItemsModel item) async {
    await _itemRepo.saveItem(item);
    _items.add(item);
    notifyListeners();
  }

  ItemsModel? getItemById(int id) {
    try {
      return _items.firstWhere((client) => client.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteItem(int id) async {
    await _itemRepo.deleteItem(id);
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<void> updateItem(ItemsModel updatedItem) async {
    await _itemRepo.updateItem(updatedItem);
    int index = _items.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      _items[index] = updatedItem;
      notifyListeners();
    }
  }
}
