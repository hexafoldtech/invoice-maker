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
  double? itemDiscountRate;

  @HiveField(8)
  double itemPrice;

  @HiveField(9)
  double totalItemPrice;

  @HiveField(10)
  bool itemTaxable;

  @HiveField(11)
  double? tax;

  @HiveField(12)
  String? unitType;

  ItemsModel(
      {required this.id,
      required this.itemName,
      required this.itemDetails,
      required this.itemUnitPrice,
      required this.itemQuantity,
      required this.isDiscount,
      this.itemDiscount,
      this.itemDiscountRate,
      required this.itemPrice,
      required this.totalItemPrice,
      required this.itemTaxable,
      this.tax,
      this.unitType});
}
