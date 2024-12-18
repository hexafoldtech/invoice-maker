import 'package:flutter/material.dart';
import 'package:invoice_maker/services/local_storage/secure_storage_interface.dart';

class AppInitializationProvider with ChangeNotifier {
  AppInitializationProvider(this._storage);
  final IStorage _storage;

  /// Keys for secure storage
  static const String _emailKey = 'email';
  static const String _userNameKey = 'user_name';

  String? _email;
  String? _userName;

  /// Getter for email.
  String? get email => _email;

  /// Setter for email.
  Future<void> setEmail(String email) async {
    _email = email;
    await _storage.writeData(key: _emailKey, value: email);
    notifyListeners();
  }

  /// Getter for user name.
  String? get userName => _userName;

  /// Setter for user name.
  Future<void> setUserName(String userName) async {
    _userName = userName;
    await _storage.writeData(key: _userNameKey, value: userName);
    notifyListeners();
  }

  /// Check if credentials exist in storage.
  Future<bool> hasCredentials() async {
    _email = await _storage.readData(key: _emailKey);
    _userName = await _storage.readData(key: _userNameKey);
    return _email != null && _userName != null;
  }

  /// Clear all stored data.
  Future<void> clearData() async {
    await _storage.deleteData(key: _userNameKey);
    await _storage.deleteData(key: _emailKey);
    _email = null;
    _userName = null;
    notifyListeners();
  }
}
