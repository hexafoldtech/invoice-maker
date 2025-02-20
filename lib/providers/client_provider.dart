import 'package:flutter/material.dart';
import '../models/ClientModel/clients_model.dart';
import '../repository/client_repo.dart';

class ClientProvider extends ChangeNotifier {
  final ClientRepo _clientRepo = ClientRepo();
  List<ClientsModel> _clients = [];

  List<ClientsModel> get clients => _clients;

  Future<void> addClient(ClientsModel client) async {
    await _clientRepo.saveClient(client);
    await fetchAllClients();
  }

  Future<void> fetchAllClients() async {
    try {
      final clients = await _clientRepo.getAllClients();
      _clients = clients;
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching clients");
    }
  }

  Future<void> removeClient(int id) async {
    await _clientRepo.deleteClient(id);
    await fetchAllClients();
  }

  Future<void> updateClient(ClientsModel client) async {
    await _clientRepo.updateClient(client);
    await fetchAllClients();
  }

  ClientsModel? getClientById(int id) {
    try {
      return _clients.firstWhere((client) => client.id == id);
    } catch (e) {
      return null;
    }
  }
}
