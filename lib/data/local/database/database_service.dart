import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../../../models/ClientModel/clients_model.dart';
import '../../../core/constants/hive_box_names.dart';
import '../../../models/ItemModel/items_model.dart';
import 'database_services.dart';

class DatabaseService implements DatabaseServices {
  @override
  Future<void> openConnection() async {
    final dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(HiveBoxNames.db);
    Hive.init(dir.path);

    Hive.registerAdapter(ClientsModelAdapter());
    await Hive.openBox<ClientsModel>('Clients');

    Hive.registerAdapter(ItemsModelAdapter());
    await Hive.openBox<ItemsModel>('Items');
  }

  @override
  Future<void> closeConnection() async {
    await Hive.close();
  }
}
