import '../models/ItemModel/items_model.dart';

abstract class ItemLocalDataSource {
  Future<void> saveItem(ItemsModel item);
  ItemsModel? getItem(int id);
  Future<List<ItemsModel>> getAllItems();
  Future<void> deleteItem(int id);
  Future<void> updateItem(ItemsModel item);
}
