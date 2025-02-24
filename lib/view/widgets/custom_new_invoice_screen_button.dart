import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/bottom_sheet.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/global_key.dart';
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';

class CustomNewInvoiceScreenButton extends StatelessWidget {
  final Widget mainChild;
  final String header;
  final String title;
  final String appbarTitle;
  const CustomNewInvoiceScreenButton(
      {super.key,
      required this.mainChild,
      required this.header,
      required this.title,
      required this.appbarTitle});

  @override
  Widget build(BuildContext context) {
    var ctx = navigatorKey.currentContext!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header, style: TextStyle(fontSize: AppSizes.s16.r)),
        const SizedBox(height: AppSizes.s8),
        GestureDetector(
          onTap: () {
            CustomBottomSheet(
              type: CustomBottomSheetType.fixed,
              fixedheightFactor: 0.9,
              header: _buildHeader(ctx),
              mainContent: Expanded(child: mainChild),
            ).showCustomBottomSheet();
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSizes.s16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_circle_outlined,
                  color: AppColors.black,
                ),
                SizedBox(
                  width: AppSizes.s6.r,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: AppSizes.s16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(ctx),
          child: Padding(
            padding: EdgeInsets.only(left: AppSizes.s12.r),
            child: Text(
              AppStrings.cancelText,
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.regular, AppSizes.s17.r),
            ),
          ),
        ),
        Text(
          appbarTitle,
          style: AppTextStyles.helveticaNeue(
              AppColors.black, FontWeightStyles.bold, AppSizes.s17.r),
        ),
        Opacity(
          opacity: 0,
          child: Text(
            AppStrings.cancelText,
            style: AppTextStyles.helveticaNeue(
                AppColors.black, FontWeightStyles.regular, AppSizes.s20.r),
          ),
        ),
      ],
    );
  }
}
