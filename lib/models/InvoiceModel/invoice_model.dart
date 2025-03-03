import 'package:hive/hive.dart';
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
  List<ItemsModel> items;

  InvoiceModel({
    required this.id,
    required this.client,
    required this.items,
  });
}
