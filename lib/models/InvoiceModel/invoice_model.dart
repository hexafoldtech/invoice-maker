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
  DateTime issueDate;

  @HiveField(3)
  DateTime dueDate;

  @HiveField(4)
  double subTotal;

  @HiveField(5)
  double discount;

  @HiveField(6)
  double? tax;

  @HiveField(7)
  String? taxType;

  @HiveField(8)
  List<ItemsModel> items;

  @HiveField(9)
  double total;

  @HiveField(10)
  String status;

  @HiveField(11)
  double paidAmount;

  InvoiceModel(
      {required this.id,
      required this.client,
      required this.issueDate,
      required this.dueDate,
      required this.items,
      required this.discount,
      required this.subTotal,
      this.tax,
      this.taxType,
      this.status = AppStrings.toggleButtonUnpaidText,
      required this.total,
      this.paidAmount = 0});
}
