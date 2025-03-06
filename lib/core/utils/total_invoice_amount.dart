import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts_styles.dart';
import '../constants/app_sizes.dart';
import 'app_text_styles.dart';

class TotalInvoiceAmount extends StatelessWidget {
  final String title;
  final double amount;
  const TotalInvoiceAmount(
      {super.key, required this.amount, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.white,
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
                    AppColors.black, FontWeight.bold, AppSizes.s18.r)),
            SizedBox(
              width: AppSizes.s60.r,
            ),
            Text('₹ $amount',
                style: AppTextStyles.helveticaNeue(
                    AppColors.black, FontWeight.bold, AppSizes.s18.r)),
            SizedBox(
              width: AppSizes.s1.w,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildQuarterSection(String quarter, double total, List months) {
  String currentMonth = DateFormat('MMMM').format(DateTime.now());
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.s12),
    ),
    elevation: 0,
    margin: const EdgeInsets.symmetric(
        vertical: AppSizes.s8, horizontal: AppSizes.s4),
    child: Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        backgroundColor: AppColors.white,
        collapsedBackgroundColor: AppColors.white,

        /// **Quarter Title & Total**
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              quarter,
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.semiBold, AppSizes.s16.r),
            ),
            Text(
              "₹ ${total.toStringAsFixed(1)}",
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.semiBold, AppSizes.s16.r),
            ),
          ],
        ),

        /// **Monthly Breakdown**
        children: months.isNotEmpty
            ? months.map((month) {
                bool isCurrentMonth = month['month'] == currentMonth;
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        month['month'],
                        style: AppTextStyles.helveticaNeue(AppColors.black,
                            FontWeightStyles.regular, AppSizes.s13.r),
                      ),

                      /// **⭐ Star for Current Month**
                      if (isCurrentMonth)
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(Icons.star,
                              color: AppColors.darkBlueShade, size: 18),
                        ),
                    ],
                  ),
                  trailing: Text(
                    "₹ ${month['amount'].toStringAsFixed(1)}",
                    style: AppTextStyles.helveticaNeue(AppColors.black,
                        FontWeightStyles.regular, AppSizes.s13.r),
                  ),
                );
              }).toList()
            : [
                Padding(
                  padding: const EdgeInsets.all(AppSizes.s16),
                  child: Text(
                    'No data available',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.helveticaNeue(
                        AppColors.grey, FontWeight.normal, AppSizes.s13.r),
                  ),
                ),
              ],
      ),
    ),
  );
}
