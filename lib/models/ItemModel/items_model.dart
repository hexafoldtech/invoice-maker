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
  bool isDiscount;

  @HiveField(6)
  double? itemDiscount;

  @HiveField(7)
  double itemPrice;

  @HiveField(8)
  bool itemTaxable;

  @HiveField(9)
  double? tax;

  ItemsModel({
    required this.id,
    required this.itemName,
    required this.itemDetails,
    required this.itemUnitPrice,
    required this.itemQuantity,
    required this.isDiscount,
    this.itemDiscount,
    required this.itemPrice,
    required this.itemTaxable,
    this.tax,
  });
}
