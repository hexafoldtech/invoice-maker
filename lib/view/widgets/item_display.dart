import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_fonts_styles.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';

class ItemDisplay extends StatelessWidget {
  final String title;
  final String desc;
  final String price;
  final String quantity;
  final String? discount;
  final String finalPrice;
  const ItemDisplay(
      {super.key,
      required this.title,
      required this.desc,
      required this.price,
      required this.quantity,
      this.discount,
      required this.finalPrice});

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
                Icon(
                  Icons.keyboard_arrow_right,
                  size: AppSizes.s20.r,
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
              TextSpan(text: "$quantity x $price"),
              discount!.isNotEmpty
                  ? TextSpan(text: " - $discount DISC")
                  : const TextSpan(),
            ],
          ),
        ),
      ],
    );
  }
}
