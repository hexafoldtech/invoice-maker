import 'package:hive/hive.dart';
part 'items_model.g.dart';

@HiveType(typeId: 1)
class ItemsModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String itemName;

  @HiveField(2)
  String itemDetails;

  @HiveField(3)
  double itemUnitPrice;

  @HiveField(4)
  int itemQuantity;

  @HiveField(5)
  double itemDiscount;

  @HiveField(6)
  bool itemTaxable;

  ItemsModel(
      {required this.id,
      required this.itemName,
      required this.itemDetails,
      required this.itemUnitPrice,
      required this.itemQuantity,
      required this.itemDiscount,
      required this.itemTaxable});
}
