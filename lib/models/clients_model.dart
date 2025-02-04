import 'package:hive/hive.dart';
part 'clients_model.g.dart';

@HiveType(typeId: 0)
class ClientsModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String clientName;

  @HiveField(2)
  String clientPhoneNumber;

  @HiveField(3)
  String clientEmail;

  @HiveField(4)
  String clientAddress;

  ClientsModel(
      {required this.id,
      required this.clientName,
      required this.clientPhoneNumber,
      required this.clientEmail,
      required this.clientAddress});
}
