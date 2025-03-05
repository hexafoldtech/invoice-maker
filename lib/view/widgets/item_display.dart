import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_fonts_styles.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';

class ItemDisplay extends StatelessWidget {
  final String title;
  final String desc;
  final String price;
  final String quantity;
  final String? discount;
  final String finalPrice;
  final VoidCallback onDelete;
  const ItemDisplay(
      {super.key,
      required this.title,
      required this.desc,
      required this.price,
      required this.quantity,
      this.discount,
      required this.finalPrice,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.medium, AppSizes.s15.r),
            ),
            Row(
              children: [
                Text(
                  finalPrice,
                  style: AppTextStyles.helveticaNeue(AppColors.black,
                      FontWeightStyles.regular, AppSizes.s15.r),
                ),
                GestureDetector(
                  onTap: onDelete,
                  child: Icon(
                    Icons.close,
                    size: AppSizes.s15.r,
                    color: AppColors.darkGrey,
                  ),
                )
              ],
            ),
          ],
        ),
        Text(
          desc,
          style: AppTextStyles.helveticaNeue(
              AppColors.black, FontWeightStyles.regular, AppSizes.s15.r),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "$quantity x $price",
                style: AppTextStyles.helveticaNeue(
                    AppColors.grey, FontWeightStyles.regular, AppSizes.s15.r),
              ),
              !discount!.contains('0.0')
                  ? TextSpan(
                      text: " - $discount ${AppStrings.percentSymbolText} DISC",
                      style: AppTextStyles.helveticaNeue(AppColors.grey,
                          FontWeightStyles.regular, AppSizes.s15.r),
                    )
                  : const TextSpan(),
            ],
          ),
        ),
      ],
    );
  }
}
