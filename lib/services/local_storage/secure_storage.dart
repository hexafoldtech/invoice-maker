import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'secure_storage_interface.dart';

/// A concrete implementation of [IStorage] using FlutterSecureStorage for secure data management.
class AppStorage implements IStorage {
  /// Constructs an [AppStorage] instance with the provided [FlutterSecureStorage].
  AppStorage(this._storage);

  /// The instance of [FlutterSecureStorage] used for secure data operations.
  final FlutterSecureStorage _storage;

  /// Deletes a value from secure storage for the given [key].
  ///
  /// [key]: The key of the value to delete.
  @override
  Future<void> deleteData({required String key}) async {
    await _storage.delete(key: key);
  }

  /// Reads a value from secure storage for the given [key].
  ///
  /// Returns the value associated with the [key], or `null` if no value exists.
  @override
  Future<String?> readData({required String key}) async {
    return await _storage.read(key: key);
  }

  /// Writes a [value] to secure storage with the associated [key].
  ///
  /// [key]: The key to associate with the value.
  /// [value]: The value to store securely.
  @override
  Future<void> writeData({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }
}
