import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';

class InvoiceIssuedDueSection extends StatelessWidget {
  final String issuedDate;
  final String dueDate;
  final String id;
  const InvoiceIssuedDueSection(
      {super.key,
      required this.issuedDate,
      required this.dueDate,
      required this.id});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.dueDateText,
                style: AppTextStyles.helveticaNeueSmall(
                    AppColors.darkGrey, FontWeight.normal)),
            const SizedBox(height: AppSizes.s8),
            Text(dueDate,
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
