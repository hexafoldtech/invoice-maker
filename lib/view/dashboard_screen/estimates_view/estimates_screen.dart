import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/view/dashboard_screen/estimates_view/estimates_item.dart';
import 'package:invoice_maker/view/dashboard_screen/estimates_view/total_recieved_amount.dart';

class EstimatesScreen extends StatelessWidget {
  const EstimatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      SizedBox(height: AppSizes.s15.r),
      Text(AppStrings.estimatesTabText,
          style: AppTextStyles.helveticaNeue(
              AppColors.black, FontWeight.bold, AppSizes.s30.r)),
      SizedBox(height: AppSizes.s11.r),
      const TotalReceivedAmount(title: AppStrings.total, amount: 5000.00),
      SizedBox(height: AppSizes.s5.r),
      SizedBox(
          height: AppSizes.s400.r,
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return const EstimatesItem();
              })),
      const SizedBox(height: AppSizes.s15)
    ]));
  }
}
