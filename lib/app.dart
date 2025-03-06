import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_initialization_provider.dart';
import 'view/app_screens/loading_screen.dart';
import 'core/definitions/route_names.dart';
import 'core/definitions/routes.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_strings.dart';

/// The main app widget that initializes the application and determines the initial route.
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// Flag to track whether initialization has been triggered.
  var _isInit = true;

  /// Flag to indicate loading state during initialization.
  var _isLoading = false;

  /// Holds the name of the initial screen to navigate to.
  var _initialScreen = '';

  @override
  void didChangeDependencies() {
    /// Obtain the app initialization provider.
    final appProvider =
        Provider.of<AppInitializationProvider>(context, listen: false);

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      /// Check for stored credentials to determine the initial screen.
      appProvider.hasCredentials().then((hasCredentials) {
        setState(() {
          _isLoading = false;
          _initialScreen = hasCredentials
              ? RouteNames.splashScreen
              : RouteNames.splashScreen;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    /// Display the loading screen during initialization or the app itself after.
    return _isLoading
        ? const LoadingScreen()
        : MaterialApp(
            title: AppStrings.invoiceMakerText,
            theme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: AppColors.white),
            initialRoute: _initialScreen,
            onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: kDebugMode);
  }
}
