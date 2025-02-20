import 'package:hive/hive.dart';
import 'package:invoice_maker/core/constants/hive_box_names.dart';
import '../../../models/ClientModel/clients_model.dart';
import '../../client_data_stores.dart';

// class ClientBoxes {
//   static Box<ClientsModel> getData() => Hive.box(HiveBoxNames.client);
// }

class ClientDataSourceImpl implements ClientLocalDataSource {
  late final Box<ClientsModel> _clientBox;

  ClientDataSourceImpl() {
    _clientBox = Hive.box<ClientsModel>(HiveBoxNames.client);
  }

  @override
  Future<void> saveClient(ClientsModel client) async {
    await _clientBox.put(client.id, client);
  }

  @override
  ClientsModel? getClient(int id) {
    return _clientBox.get(id);
  }

  @override
  Future<List<ClientsModel>> getAllClients() async {
    return _clientBox.values.toList();
  }

  @override
  Future<void> deleteClient(int id) async {
    await _clientBox.delete(id);
  }

  @override
  Future<void> updateClient(ClientsModel client) async {
    if (_clientBox.containsKey(client.id)) {
      await _clientBox.put(client.id, client);
    }
  }
}
