
import 'package:hive/hive.dart';
part 'items_model.g.dart';

@HiveType(typeId: 0)
class ItemsModel extends HiveObject {
  @HiveField(0)
  String itemName;

  @HiveField(1)
  String itemDetails;

  @HiveField(2)
  double itemUnitPrice;

  @HiveField(3)
  int itemQuantity;

  @HiveField(4)
  double itemDiscount;

   @HiveField(5)
  bool itemTaxable;

  ItemsModel(
      {required this.itemName,
      required this.itemDetails,
      required this.itemUnitPrice,
      required this.itemQuantity,
      required this.itemDiscount,
      required this.itemTaxable
      });
}
