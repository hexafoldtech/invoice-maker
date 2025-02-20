import '../models/ClientModel/clients_model.dart';

abstract class ClientLocalDataSource {
  Future<void> saveClient(ClientsModel client);
  ClientsModel? getClient(int id);
  Future<List<ClientsModel>> getAllClients();
  Future<void> deleteClient(int id);
  Future<void> updateClient(ClientsModel client);
}