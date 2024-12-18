abstract class IStorage {
  Future<void> writeData({required String key, required String value});
  Future<String?> readData({required String key});
  Future<void> deleteData({required String key});
}
