import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "../../../core/utils/app_text_styles.dart";
import '../../../core/utils/extensions/number_formatter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_fonts_styles.dart';
import '../../../core/constants/app_sizes.dart';

class EstimatesItem extends StatelessWidget {
  final String client;
  final int id;
  final String dueDate;
  final double amount;
  final VoidCallback onTap;
  const EstimatesItem(
      {super.key,
      required this.client,
      required this.id,
      required this.dueDate,
      required this.amount,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        // Icon on the left
        title: Text(client,
            style: AppTextStyles.helveticaNeue(
                AppColors.black, FontWeightStyles.semiBold, AppSizes.s14.r)),
        subtitle: Text('#EST${id + 1}, $dueDate',
            style: AppTextStyles.helveticaNeue(
                AppColors.grey, FontWeightStyles.regular, AppSizes.s12.r)),
        trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("${AppStrings.rupeeSymbolText} ${amount.formatWithCommas()}",
                  style: AppTextStyles.helveticaNeue(AppColors.black,
                      FontWeightStyles.semiBold, AppSizes.s14.r))
            ]),
        onTap: onTap);
  }
}
