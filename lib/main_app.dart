import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:loggy/loggy.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'app_providers.dart';
import 'core/constants/global_key.dart';
import 'core/utils/package_info_util.dart';
import 'services/local_storage/secure_storage.dart';

/// Application-wide secure storage instance.
AppStorage appStorage = AppStorage(const FlutterSecureStorage());

/// Entry point for the application with enhanced error handling and initialization.
///
/// This function initializes system settings such as screen orientation,
/// logging, and multi-provider configurations for the app.
void mainApp() {
  runZonedGuarded(() async {
    /// Ensure Flutter framework is initialized.
    WidgetsFlutterBinding.ensureInitialized();

    /// Set device orientation to portrait only.
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    /// Initialize logging using Loggy.
    Loggy.initLoggy();

    /// TODO: Initialize Firebase services if required.

    /// Initialize package information.
    await PackageInfoUtil.init();

    /// Run the application with configured providers and screen utilities.
    runApp(MultiProvider(
        providers: appProviders,
        child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: kDebugMode,
            home: ScreenUtilInit(
                designSize: const Size(375, 812),

                /// Default design size for screen scaling.
                minTextAdapt: true,

                /// Adapts text size based on screen size.
                splitScreenMode: true,

                /// Enables split-screen adaptability.
                builder: (context, child) {
                  return Stack(children: [
                    const App(),

                    /// The app version label, displayed at the bottom-left corner.
                    Positioned(
                        bottom: AppSizes.s4.r,
                        left: AppSizes.s4.r,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.s8.r,
                                vertical: AppSizes.s2.r),
                            decoration: BoxDecoration(
                                color: AppColors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text("v${PackageInfoUtil.version}",
                                style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: AppSizes.s10.r))))
                  ]);
                }))));
  }, (Object error, StackTrace stack) {
    /// Handle uncaught errors gracefully.
    _handleUncaughtError(error, stack);
  });
}

/// Handles uncaught errors and displays an error widget.
///
/// [error] - The caught error object.
/// [stack] - Stack trace associated with the error.
void _handleUncaughtError(Object error, StackTrace stack) {
  /// Create a default error widget to display user-friendly error messages.
  Widget errorWidget = const MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      home: Scaffold(
          body: Center(
              child: Text(
                  '${AppStrings.somethingWentWrongText}\n${AppStrings.pleaseTryAgainText}'))));

  /// Assign custom error widget to the Flutter error handler.
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) => errorWidget;

  /// Log the error details and exit the application in release mode.
  if (!kDebugMode) {
    exit(1);
  } else {
    debugPrint('Error: $error\nStack trace: $stack');
  }
}
