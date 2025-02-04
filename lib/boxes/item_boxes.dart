import 'package:hive/hive.dart';
import 'package:invoice_maker/models/ItemModel/items_model.dart';

class ItemBoxes {
  static Box<ItemsModel> getData() => Hive.box('clients');
}
