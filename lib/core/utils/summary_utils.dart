import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/utils/extensions/number_formatter.dart';
import 'app_text_styles.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts_styles.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';

class SummaryUtils {
  Widget buildSummaryRow(String title, double amount, {Widget? trailingIcon}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.regular, AppSizes.s17.r),
            ),
            if (trailingIcon == null)
              Text(
                amount.formatWithCommas(),
                style: AppTextStyles.helveticaNeue(
                    AppColors.black, FontWeightStyles.regular, AppSizes.s17.r),
              ),
            if (trailingIcon != null) ...[
              Row(
                children: [
                  Text(
                    amount.formatWithCommas(),
                    style: AppTextStyles.helveticaNeue(AppColors.black,
                        FontWeightStyles.regular, AppSizes.s17.r),
                  ),
                  SizedBox(width: AppSizes.s5.r),
                  trailingIcon,
                ],
              ),
            ],
          ],
        ),
        SizedBox(
          height: AppSizes.s12.r,
        ),
      ],
    );
  }

  Widget buildTotalRow(double totalAmount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.totalCapitalText,
          style: AppTextStyles.helveticaNeue(
              AppColors.black, FontWeightStyles.bold, AppSizes.s17.r),
        ),
        Row(
          children: [
            Container(
              height: AppSizes.s30.r,
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.s3.r,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: 'INR',
                  items: ['INR', 'USD', 'EUR']
                      .map((currency) => DropdownMenuItem<String>(
                            value: currency,
                            child: Text(currency),
                          ))
                      .toList(),
                  onChanged: (value) {
                    // TODO Handle currency change
                  },
                ),
              ),
            ),
            const SizedBox(width: AppSizes.s8),
            Text(
              '${AppStrings.rupeeSymbolText} ${totalAmount.formatWithCommas()}',
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.bold, AppSizes.s17.r),
            ),
          ],
        ),
      ],
    );
  }
}
