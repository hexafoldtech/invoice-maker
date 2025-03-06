import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/definitions/route_names.dart';
import '../../core/utils/app_button.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<void> markFirstLaunchCompleted(BuildContext ctx) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstLaunch', false);
    Navigator.pushReplacementNamed(ctx, RouteNames.dashboardScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/icon.png', height: 150),
            const SizedBox(height: 20),
            Text(
              AppStrings.welcomeText,
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.semiBold, AppSizes.s25.r),
            ),
            SizedBox(height: AppSizes.s14.r),
            Text(
              AppStrings.welcomeTagLineText,
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.semiBold, AppSizes.s16.r),
            ),
            const SizedBox(height: 40),
            AppButton(
              type: ButtonType.elevated,
              backgroundColor: AppColors.darkBlueShade,
              label: AppStrings.getStartedText,
              fontSize: AppSizes.s14.r,
              action: () => markFirstLaunchCompleted(context),
            ),
          ],
        ),
      ),
    );
  }
}
