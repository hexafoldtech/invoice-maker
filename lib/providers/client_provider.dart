import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../core/constants/hive_box_names.dart';
import '../models/ClientModel/clients_model.dart';
import '../repository/client_repo.dart';

enum AppUIStates { loading, empty, success, none }

class ClientProvider extends ChangeNotifier {
  final ClientRepo _clientRepo = ClientRepo();
  List<ClientsModel> _clients = [];
  AppUIStates _state = AppUIStates.none;

  List<ClientsModel> get clients => _clients;
  AppUIStates get state => _state;

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
  bool _isLoading = false;

  get saveToClients => _saveToClients;
  get isclientFilled => _isclientFilled;
  bool get isLoading => _isLoading;

  ClientsModel? _selectedClient;

  ClientsModel? get selectedClient => _selectedClient;

  /// for checking and rendering toggle Switch if field is filled
  void _toggleSwitchVisibility() {
    _isclientFilled = _clientNameController.text.isNotEmpty;
    _saveToClients = _clientNameController.text.isNotEmpty;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
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
    final box = Hive.box<ClientsModel>(HiveBoxNames.client);
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
    setLoading(true);
    try {
      await _clientRepo.saveClient(client);
      await fetchAllClients();
    } finally {
      setLoading(false);
    }
  }

  Future<void> fetchAllClients() async {
    _state = AppUIStates.loading;
    notifyListeners();
    try {
      final clients = await _clientRepo.getAllClients();
      _clients = clients;
      _state = _clients.isEmpty ? AppUIStates.empty : AppUIStates.success;
      notifyListeners();
    } catch (e) {
      _state = AppUIStates.empty;
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
