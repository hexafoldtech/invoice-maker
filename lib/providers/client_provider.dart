import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/ClientModel/clients_model.dart';
import '../repository/client_repo.dart';

class ClientProvider extends ChangeNotifier {
  final ClientRepo _clientRepo = ClientRepo();
  List<ClientsModel> _clients = [];

  List<ClientsModel> get clients => _clients;

  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _clientPhoneNumberController =
      TextEditingController();
  final TextEditingController _clientEmailController = TextEditingController();
  final TextEditingController _clientAddressController =
      TextEditingController();

  TextEditingController get nameController => _clientNameController;
  TextEditingController get phoneController => _clientPhoneNumberController;
  TextEditingController get emailController => _clientEmailController;
  TextEditingController get addressController => _clientAddressController;

  bool _saveToClients = false;
  bool _isclientFilled = false;

  get saveToClients => _saveToClients;
  get isclientFilled => _isclientFilled;

  ClientsModel? _selectedClient;

  ClientsModel? get selectedClient => _selectedClient;

  void _toggleSwitchVisibility() {
    _isclientFilled = _clientNameController.text.isNotEmpty;
    _saveToClients = _clientNameController.text.isNotEmpty;
    notifyListeners();
  }

  void setSaveToClients(bool value) {
    _saveToClients = value;
    notifyListeners();
  }

  // Initialize listeners
  void initListners() {
    _clientNameController.addListener(_toggleSwitchVisibility);
  }

  void clearForm() {
    _clientNameController.clear();
    _clientPhoneNumberController.clear();
    _clientEmailController.clear();
    _clientAddressController.clear();
    _saveToClients = false;
    _isclientFilled = false;
    notifyListeners();
  }

  ClientsModel createClientModel() {
    final box = Hive.box<ClientsModel>('clients');
    final int newId = (box.isEmpty)
        ? 0
        : box.keys
                .cast<int>()
                .reduce((value, element) => value > element ? value : element) +
            1;

    return ClientsModel(
      id: newId,
      clientName: nameController.text,
      clientPhoneNumber: phoneController.text,
      clientEmail: emailController.text,
      clientAddress: addressController.text,
    );
  }

  void selectClient(ClientsModel client) {
    _selectedClient = client;
    notifyListeners();
  }

  void clearSelectedClient() {
    _selectedClient = null;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

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

  // String getNextInvoiceId() {
  //   return (_invoices.length + 1).toString().padLeft(3, '0');
  // }
}
