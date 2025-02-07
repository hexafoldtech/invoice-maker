import 'package:invoice_maker/main_app.dart';
import 'package:invoice_maker/providers/app_initialization_provider.dart';
import 'package:invoice_maker/providers/bottom_navigation_provider.dart';
import 'package:invoice_maker/providers/dashboard_provider.dart';
import 'package:invoice_maker/providers/tab_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<AppInitializationProvider>(
      create: (_) => AppInitializationProvider(appStorage)),
  ChangeNotifierProvider(create: (context) => TabProvider()),
  ChangeNotifierProvider(create: (context) => BottomNavigationProvider()),
   ChangeNotifierProvider<DashboardProvider>(create: (context) => DashboardProvider()),
];
