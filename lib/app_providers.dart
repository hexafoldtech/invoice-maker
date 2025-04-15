import 'package:invoice_maker/providers/estimate_provider.dart';
import 'package:invoice_maker/providers/reports_provider.dart';

import 'main_app.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'providers/app_initialization_provider.dart';
import 'providers/bottom_navigation_provider.dart';
import 'providers/form_provider.dart';
import 'providers/tab_provider.dart';
import 'providers/dashboard_provider.dart';
import 'providers/client_provider.dart';
import 'providers/item_provider.dart';
import 'providers/invoice_provider.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<AppInitializationProvider>(
      create: (_) => AppInitializationProvider(appStorage)),
  ChangeNotifierProvider(create: (context) => TabProvider()),
  ChangeNotifierProvider(create: (context) => BottomNavigationProvider()),
  ChangeNotifierProvider<DashboardProvider>(
      create: (context) => DashboardProvider()),
  ChangeNotifierProvider(create: (_) => ClientProvider()),
  ChangeNotifierProvider(create: (_) => ItemProvider()),
  ChangeNotifierProvider(create: (_) => FormProvider()),
  ChangeNotifierProvider(create: (ctx) => InvoiceProvider(context: ctx)),
  ChangeNotifierProvider(create: (_) => ReportsProvider()),
  ChangeNotifierProvider(create: (ctx) => EstimateProvider(context: ctx)),
];
