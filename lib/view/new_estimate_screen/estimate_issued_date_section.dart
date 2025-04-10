import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';

class EstimateIssuedDueSection extends StatelessWidget {
  final String issuedDate;
  final String id;
  const EstimateIssuedDueSection(
      {super.key, required this.issuedDate, required this.id});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.issuedDateText,
                style: AppTextStyles.helveticaNeueSmall(
                    AppColors.darkGrey, FontWeight.normal)),
            const SizedBox(height: AppSizes.s8),
            Text(issuedDate,
                style: AppTextStyles.helveticaNeueSmall(
                    AppColors.black, FontWeight.bold)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(AppStrings.numberText,
                style: AppTextStyles.helveticaNeueSmall(
                    AppColors.darkGrey, FontWeight.normal)),
            const SizedBox(height: AppSizes.s8),
            Text(id,
                style: AppTextStyles.helveticaNeueSmall(
                    AppColors.black, FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
