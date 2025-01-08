import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';

class TotalReceivedAmount extends StatelessWidget {
  final String title;
  final double amount;
  const TotalReceivedAmount(
      {super.key, required this.title, required this.amount});

  @override
  Widget build(Object context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyles.helveticaNeueItem(
              AppColors.darkGrey, FontWeight.bold),
        ),
        const SizedBox(
          width: AppSizes.s10,
        ),
        Text(
          "\$ $amount",
          style: AppTextStyles.helveticaNeueItem(
              AppColors.darkGrey, FontWeight.bold),
        ),
      ],
    );
  }
}
