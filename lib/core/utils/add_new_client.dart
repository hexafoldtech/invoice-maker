import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../providers/client_provider.dart';
import '../../view/widgets/new_client_screen.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/bottom_sheet.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../constants/global_key.dart';

Widget buildAddClientButton(VoidCallback onTap) {
  return Padding(
    padding: EdgeInsets.only(left: AppSizes.s16.r, bottom: AppSizes.s7.r),
    child: GestureDetector(
      child: Row(
        children: [
          const Icon(
            Icons.add,
            color: AppColors.green,
            size: AppSizes.s20,
          ),
          const SizedBox(width: AppSizes.s8),
          GestureDetector(
            onTap: () {
              Provider.of<ClientProvider>(navigatorKey.currentContext!,
                      listen: false)
                  .clearForm();
              CustomBottomSheet(
                type: CustomBottomSheetType.fixed,
                header: _buildHeader(onTap),
                fixedheightFactor: 0.88,
                mainContent: const Expanded(
                  child: NewClientScreen(),
                ),
              ).showCustomBottomSheet();
            },
            child: Text(
              AppStrings.addNewClientText,
              style: AppTextStyles.helveticaNeueItem(
                  AppColors.green, FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildHeader(VoidCallback onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () {
          Provider.of<ClientProvider>(navigatorKey.currentContext!,
                  listen: false)
              .clearForm();
          Navigator.pop(navigatorKey.currentContext!);
        },
        child: Padding(
          padding: EdgeInsets.only(left: AppSizes.s12.r),
          child: Text(
            AppStrings.cancelText,
            style: AppTextStyles.helveticaNeue(
                AppColors.black, FontWeightStyles.regular, AppSizes.s17.r),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: EdgeInsets.only(right: AppSizes.s12.r),
          child: Text(
            AppStrings.doneText,
            style: AppTextStyles.helveticaNeue(
                AppColors.black, FontWeightStyles.regular, AppSizes.s17.r),
          ),
        ),
      ),
    ],
  );
}
