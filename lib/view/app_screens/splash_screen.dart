import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/definitions/route_names.dart';
import '../../core/utils/app_text_styles.dart';
import "../../core/constants/app_fonts_styles.dart";
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2)); // Splash duration
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;

    if (isFirstLaunch) {
      Navigator.pushReplacementNamed(context, RouteNames.welcomeScreen);
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.dashboardScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Image.asset(
              'assets/images/icon.png',
              height: AppSizes.s70.r,
              width: AppSizes.s70.r,
            ),
            SizedBox(height: AppSizes.s15.r),
            Text(
              AppStrings.invoiceMakerText,
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.semiBold, AppSizes.s25.r),
            ),
            SizedBox(height: AppSizes.s30.r),
            Text(
              AppStrings.tagLineText,
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.medium, AppSizes.s16.r),
            ),
          ],
        ),
      ),
    );
  }
}
