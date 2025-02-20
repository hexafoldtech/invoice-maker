import 'package:hive/hive.dart';
import '../../../models/ItemModel/items_model.dart';
import '../../../core/constants/hive_box_names.dart';
import '../../item_data_sources.dart';

// class ItemBoxes {
//   static Box<ItemsModel> getData() => Hive.box(HiveBoxNames.items);
// }

class ItemDataSourceImpl extends ItemLocalDataSource {
  late final Box<ItemsModel> _itemBox;

  ItemDataSourceImpl() {
    _itemBox = Hive.box<ItemsModel>(HiveBoxNames.items);
  }

  @override
  Future<void> deleteItem(int id) async {
    await _itemBox.delete(id);
  }

  @override
  Future<List<ItemsModel>> getAllItems() async {
    return _itemBox.values.toList();
  }

  @override
  ItemsModel? getItem(int id) {
    return _itemBox.get(id);
  }

  @override
  Future<void> saveItem(ItemsModel item) async {
    await _itemBox.put(item.id, item);
  }

  @override
  Future<void> updateItem(ItemsModel item) async {
    if (_itemBox.containsKey(item.id)) {
      await _itemBox.put(item.id, item);
    }
  }
}
