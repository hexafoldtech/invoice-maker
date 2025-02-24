import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_text_styles.dart';
import "../../core/constants/app_colors.dart";
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';

class Summary extends StatelessWidget {
  final double amount;
  const Summary({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppStrings.summaryText),
        const SizedBox(height: AppSizes.s4),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
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
                            // Handle currency change
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.s8),
                    Text(
                      '₹ $amount',
                      style: AppTextStyles.helveticaNeue(AppColors.black,
                          FontWeightStyles.bold, AppSizes.s17.r),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
