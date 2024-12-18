import 'package:flutter/material.dart';
import 'package:invoice_maker/core/definitions/route_names.dart';

import '../../view/app_screens/error_screen.dart';
import '../../view/app_screens/under_development_screen.dart';
import '../../view/dashboard_screen/dashboard_screen.dart';
import '../../view/app_screens/loading_screen.dart';
import '../../view/login_screen/login_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.loadingScreen:
        return MaterialPageRoute(builder: (_) => const LoadingScreen());
      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteNames.dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case RouteNames.underDevelopmentScreen:
        return MaterialPageRoute(
            builder: (_) => const UnderDevelopmentScreen());
      case RouteNames.errorScreen:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => const UnderDevelopmentScreen());
    }
  }
}
