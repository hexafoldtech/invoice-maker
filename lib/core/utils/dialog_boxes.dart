import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_fonts_styles.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import '../constants/app_strings.dart';
import '../constants/global_key.dart';

class DialogBoxes {
  /// [Dialog box to display under development and coming soon features]
  void showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.s10.r)),
          title: Text(
            AppStrings.comingSoonText,
            style: AppTextStyles.helveticaNeue(
                AppColors.black, FontWeightStyles.regular, AppSizes.s14.r),
          ),
          content: Text(
            AppStrings.underDevText,
            style: AppTextStyles.helveticaNeue(
                AppColors.black, FontWeightStyles.regular, AppSizes.s14.r),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(navigatorKey.currentContext!),
              child: Text(
                AppStrings.okText,
                style: AppTextStyles.helveticaNeue(
                    AppColors.black, FontWeightStyles.regular, AppSizes.s14.r),
              ),
            ),
          ],
        );
      },
    );
  }

  /// [Dialog box to display an alert to fill the whole invoice before preview]
  void showPreviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.s10.r)),
          content: Text(
            AppStrings.completeInvoicePreviewText,
            style: AppTextStyles.helveticaNeue(
                AppColors.black, FontWeightStyles.regular, AppSizes.s14.r),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(navigatorKey.currentContext!),
              child: Text(
                AppStrings.okText,
                style: AppTextStyles.helveticaNeue(
                    AppColors.black, FontWeightStyles.regular, AppSizes.s14.r),
              ),
            ),
          ],
        );
      },
    );
  }

  /// [Dialog box to display an alert to fill the whole invoice before creating it]
  void showCreateInvoiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.s10.r)),
          content: Text(
            AppStrings.completeInvoiceText,
            style: AppTextStyles.helveticaNeue(
                AppColors.black, FontWeightStyles.regular, AppSizes.s14.r),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(navigatorKey.currentContext!),
              child: Text(
                AppStrings.okText,
                style: AppTextStyles.helveticaNeue(
                    AppColors.black, FontWeightStyles.regular, AppSizes.s14.r),
              ),
            ),
          ],
        );
      },
    );
  }
}
