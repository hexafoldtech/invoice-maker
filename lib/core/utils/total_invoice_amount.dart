import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';

class TotalInvoiceAmount extends StatelessWidget {
  final String title;
  final double amount;
  const TotalInvoiceAmount(
      {super.key, required this.amount, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child:
          // Total Section
          Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.s16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: AppTextStyles.helveticaNeue(
                      AppColors.black, FontWeight.bold)),
              Text('₹ $amount',
                  style: AppTextStyles.helveticaNeue(
                      AppColors.black, FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildQuarterSection(
    String quarter, String total, List<Map<String, String>> months) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.s8),
    ),
    margin: const EdgeInsets.all(AppSizes.s16),
    child: ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              quarter,
              style:
                  AppTextStyles.helveticaNeue(AppColors.black, FontWeight.bold),
            ),
            Text(
              total,
              style:
                  AppTextStyles.helveticaNeue(AppColors.black, FontWeight.bold),
            ),
          ],
        ),
      ),
      children: months.isNotEmpty
          ? months
              .map((month) => ListTile(
                    title: Text(
                      month['month']!,
                      style: AppTextStyles.helveticaNeueSmall(
                          AppColors.grey, FontWeight.normal),
                    ),
                    trailing: Text(
                      month['amount']!,
                      style: AppTextStyles.helveticaNeueSmall(
                          AppColors.grey, FontWeight.normal),
                    ),
                  ))
              .toList()
          : [
              Padding(
                padding: const EdgeInsets.all(AppSizes.s16),
                child: Text(
                  'No data available',
                  style: AppTextStyles.helveticaNeueSmall(
                      AppColors.grey, FontWeight.normal),
                ),
              ),
            ],
    ),
  );
}
