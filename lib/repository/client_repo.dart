import 'package:flutter/material.dart';
import '../models/ClientModel/clients_model.dart';
import '../data/local/datasources/client_data_source.dart';

class ClientRepo {
  final ClientDataSourceImpl clientDataSource = ClientDataSourceImpl();

  Future<void> saveClient(ClientsModel client) async {
    try {
      await clientDataSource.saveClient(client);
    } catch (e) {
      debugPrint("Error");
    }
  }

  void getClient(int id) {
    try {
      clientDataSource.getClient(id);
    } catch (e) {
      debugPrint("Error");
    }
  }

  Future<List<ClientsModel>> getAllClients() async {
    try {
      var clients = await clientDataSource.getAllClients();
      return clients;
    } catch (e) {
      debugPrint("Error");
    }
    return [];
  }

  Future<void> deleteClient(int id) async {
    try {
      await clientDataSource.deleteClient(id);
    } catch (e) {
      debugPrint("Error");
    }
  }

  Future<void> updateClient(ClientsModel client) async {
    try {
      await clientDataSource.updateClient(client);
    } catch (e) {
      debugPrint("Error");
    }
  }
}
