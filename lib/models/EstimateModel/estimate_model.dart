import 'package:hive/hive.dart';
import '../ClientModel/clients_model.dart';
import '../ItemModel/items_model.dart';
part 'estimate_model.g.dart';

@HiveType(typeId: 3)
class EstimateModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  ClientsModel client;

  @HiveField(2)
  DateTime issueDate;

  @HiveField(3)
  double subTotal;

  @HiveField(4)
  double discount;

  @HiveField(5)
  double? tax;

  @HiveField(6)
  String? taxType;

  @HiveField(7)
  List<ItemsModel> items;

  @HiveField(8)
  double total;

  EstimateModel({
    required this.id,
    required this.client,
    required this.issueDate,
    required this.items,
    required this.discount,
    required this.subTotal,
    this.tax,
    this.taxType,
    required this.total,
  });
}
