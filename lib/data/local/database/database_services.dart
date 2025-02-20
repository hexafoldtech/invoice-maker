abstract class DatabaseServices {
  Future<void> openConnection();
  Future<void> closeConnection();
}