import 'package:flutter/material.dart';
import 'route_names.dart';
import '../../view/new_invoice_screen/add_tax_screen.dart';
import '../../view/app_screens/error_screen.dart';
import '../../view/app_screens/under_development_screen.dart';
import '../../view/app_screens/loading_screen.dart';
import '../../view/dashboard_screen/dashboard_screen.dart';
import '../../view/login_screen/login_screen.dart';
import '../../view/new_invoice_screen/new_invoice_screen.dart';
import '../../view/new_estimate_screen/new_estimate_screen.dart';
import '../../view/app_screens/splash_screen.dart';
import '../utils/transition.dart';
import '../../view/app_screens/welcome_screen.dart';
import '../../view/new_invoice_screen/preview_screen.dart';
import '../../view/new_invoice_screen/payments_screen.dart';
import '../../view/new_invoice_screen/invoice_details_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.loadingScreen:
        return MaterialPageRoute(builder: (_) => const LoadingScreen());
      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteNames.dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case RouteNames.createInvoiceScreen:
        return CustomPageTransition(
          child: const NewInvoiceScreen(),
        );
      case RouteNames.createEstimateScreen:
        return CustomPageTransition(
          child: const NewEstimateScreen(),
        );
      case RouteNames.underDevelopmentScreen:
        return MaterialPageRoute(
            builder: (_) => const UnderDevelopmentScreen());
      case RouteNames.errorScreen:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
      case RouteNames.addTaxScreen:
        return MaterialPageRoute(builder: (_) => const AddTaxScreen());
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case RouteNames.previewScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return CustomPageTransition(
          child: PreviewScreen(
            type: args!['type'],
            invoice: args['invoice'],
          ),
        );
      case RouteNames.paymentsScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
            builder: (_) => PaymentScreen(
                  invoice: args!['invoice'],
                ));
      case RouteNames.invoiceDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
            builder: (_) => InvoiceDetailsScreen(
                  invoice: args!['invoice'],
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => const UnderDevelopmentScreen());
    }
  }
}
