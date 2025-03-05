import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_fonts_styles.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/definitions/route_names.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to Home after 2 seconds
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, RouteNames.dashboardScreen);
    });
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
              AppStrings.welcomeText,
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
