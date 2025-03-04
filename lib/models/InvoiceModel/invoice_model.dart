import 'package:hive/hive.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import '../ClientModel/clients_model.dart';
import '../ItemModel/items_model.dart';
part 'invoice_model.g.dart';

@HiveType(typeId: 2)
class InvoiceModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  ClientsModel client;

  @HiveField(2)
  String dueDate;

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

  @HiveField(9)
  String status;

  InvoiceModel({
    required this.id,
    required this.client,
    required this.dueDate,
    required this.items,
    required this.discount,
    required this.subTotal,
    this.tax,
    this.taxType,
    this.status = AppStrings.toggleButtonUnpaidText,
    required this.total,
  });
}
