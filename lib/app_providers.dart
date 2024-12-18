import 'package:invoice_maker/main_app.dart';
import 'package:invoice_maker/providers/app_initialization_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<AppInitializationProvider>(
      create: (_) => AppInitializationProvider(appStorage))
];
