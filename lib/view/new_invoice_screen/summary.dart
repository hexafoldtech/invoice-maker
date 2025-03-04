import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:provider/provider.dart";
import '../../providers/item_provider.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/constants/global_key.dart';
import "../../core/constants/app_colors.dart";
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemProvider>(
      builder: (context, itemProvider, child) {
        var totalAmount = itemProvider.selectedItems
            .fold(0.0, (sum, e) => sum + e.totalItemPrice);
        var discountAmount = itemProvider.selectedItems
            .fold(0.0, (sum, e) => sum + e.itemDiscount!);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.summaryText,
              style: AppTextStyles.helveticaNeueSmall(
                  AppColors.darkGrey, FontWeightStyles.regular),
            ),
            const SizedBox(height: AppSizes.s4),
            itemProvider.selectedItems.isNotEmpty
                ? Column(
                    children: [
                      _buildSummaryRow(AppStrings.subTotalText, totalAmount),
                      _buildSummaryRow(AppStrings.discountText, discountAmount),
                      _buildSummaryRow(AppStrings.taxText, 0,
                          trailingIcon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: AppSizes.s15,
                            color: AppColors.darkGrey,
                          )),
                    ],
                  )
                : const SizedBox.shrink(),
            _buildTotalRow()
          ],
        );
      },
    );
  }

  Widget _buildSummaryRow(String title, double amount, {Icon? trailingIcon}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.regular, AppSizes.s15.r),
            ),
            if (trailingIcon == null)
              Text(
                '$amount',
                style: AppTextStyles.helveticaNeue(
                    AppColors.black, FontWeightStyles.regular, AppSizes.s15.r),
              ),
            if (trailingIcon != null) ...[
              Row(
                children: [
                  Text(
                    '$amount',
                    style: AppTextStyles.helveticaNeue(AppColors.black,
                        FontWeightStyles.regular, AppSizes.s15.r),
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

  Widget _buildTotalRow() {
    var totalAmount = Provider.of<ItemProvider>(navigatorKey.currentContext!)
        .selectedItems
        .fold(0.0, (sum, e) => sum + e.itemPrice);
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
              '${AppStrings.rupeeSymbolText} $totalAmount',
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.bold, AppSizes.s17.r),
            ),
          ],
        ),
      ],
    );
  }
}
