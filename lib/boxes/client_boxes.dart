import 'package:hive/hive.dart';
import 'package:invoice_maker/models/clients_model.dart';

class ClientBoxes {
  static Box<ClientsModel> getData() => Hive.box('clients');
}
