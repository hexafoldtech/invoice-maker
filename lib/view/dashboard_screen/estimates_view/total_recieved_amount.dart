import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_fonts_styles.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/core/utils/extensions/string_formatter.dart';

class TotalReceivedAmount extends StatelessWidget {
  final String title;
  final double amount;
  const TotalReceivedAmount(
      {super.key, required this.title, required this.amount});

  @override
  Widget build(Object context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(title.formatString(),
          style: AppTextStyles.helveticaNeue(
              AppColors.darkGrey, FontWeightStyles.semiBold, AppSizes.s14.r)),
      SizedBox(width: AppSizes.s10.r),
      Text("\$ $amount",
          style: AppTextStyles.helveticaNeue(
              AppColors.darkGrey, FontWeightStyles.semiBold, AppSizes.s14.r))
    ]);
  }
}
