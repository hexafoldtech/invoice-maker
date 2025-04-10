import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/estimate_provider.dart';
import '../../providers/item_provider.dart';
import '../../core/definitions/route_names.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/summary_utils.dart';
import "../../core/constants/app_colors.dart";
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';

class EstimateSummary extends StatelessWidget {
  const EstimateSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EstimateProvider>(
      builder: (context, estimateProvider, child) {
        var subTotal = estimateProvider.subTotal;
        var discountAmount = estimateProvider.totalDiscount;
        var totalAmount = estimateProvider.totalAmount;
        var tax = double.parse(estimateProvider.tax.toStringAsFixed(2));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.summaryText,
              style: AppTextStyles.helveticaNeueSmall(
                  AppColors.darkGrey, FontWeightStyles.regular),
            ),
            SizedBox(height: AppSizes.s10.r),
            Provider.of<ItemProvider>(context).selectedItems.isNotEmpty
                ? Column(
                    children: [
                      SummaryUtils()
                          .buildSummaryRow(AppStrings.subTotalText, subTotal),
                      SummaryUtils().buildSummaryRow(
                          AppStrings.discountText, discountAmount),
                      SummaryUtils()
                          .buildSummaryRow(estimateProvider.taxText, tax,
                              trailingIcon: GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, RouteNames.addTaxInEstimateScreen),
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: AppSizes.s15.r,
                                  color: AppColors.darkGrey,
                                ),
                              )),
                    ],
                  )
                : const SizedBox.shrink(),
            SummaryUtils().buildTotalRow(totalAmount),
            SizedBox(
              height: AppSizes.s25.r,
            ),
            Provider.of<ItemProvider>(context).selectedItems.isNotEmpty
                ? SummaryUtils()
                    .buildSummaryRow(AppStrings.recievedPayText, 0.0,
                        trailingIcon: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, RouteNames.paymentsScreen),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: AppSizes.s15.r,
                            color: AppColors.darkGrey,
                          ),
                        ))
                : const SizedBox.shrink()
          ],
        );
      },
    );
  }
}
