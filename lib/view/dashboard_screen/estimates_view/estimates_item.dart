import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';

import '../../../core/constants/app_fonts_styles.dart';
import '../../../core/constants/app_sizes.dart';

class EstimatesItem extends StatelessWidget {
  const EstimatesItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        // Icon on the left
        title: Text('Quantum',
            style: AppTextStyles.helveticaNeue(
                AppColors.black, FontWeightStyles.semiBold, AppSizes.s14.r)),
        subtitle: Text('#EST1,2 Jan',
            style: AppTextStyles.helveticaNeue(
                AppColors.grey, FontWeightStyles.regular, AppSizes.s12.r)),
        trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("₹ 4500.00", // inr symbol added
                  style: AppTextStyles.helveticaNeue(AppColors.black,
                      FontWeightStyles.semiBold, AppSizes.s14.r))
            ]),
        onTap: () {});
  }
}
