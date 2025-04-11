import 'package:hive_flutter/hive_flutter.dart';
import 'package:invoice_maker/models/EstimateModel/estimate_model.dart';
import 'package:invoice_maker/models/InvoiceModel/invoice_model.dart';
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
    await Hive.openBox<ClientsModel>(HiveBoxNames.client);

    Hive.registerAdapter(ItemsModelAdapter());
    await Hive.openBox<ItemsModel>(HiveBoxNames.items);

    Hive.registerAdapter(InvoiceModelAdapter());
    await Hive.openBox<InvoiceModel>(HiveBoxNames.invoices);

    Hive.registerAdapter(EstimateModelAdapter());
    await Hive.openBox<EstimateModel>(HiveBoxNames.estimates);
  }

  @override
  Future<void> closeConnection() async {
    await Hive.close();
  }
}
