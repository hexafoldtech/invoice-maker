import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/core/utils/total_invoice_amount.dart';
import 'package:invoice_maker/core/utils/year_picker.dart';

class ReportsScreens extends StatelessWidget {
  ReportsScreens({super.key});
  final List<Map<String, dynamic>> quarterlyData = [
    {
      'quarter': 'Q1',
      'total': 4500.0,
      'months': [
        {'month': 'March', 'amount': 4500.0},
        {'month': 'February', 'amount': 0.0},
        {'month': 'January', 'amount': 0.0}
      ]
    },
    {'quarter': 'Q2', 'total': 0.0, 'months': []},
    {'quarter': 'Q3', 'total': 0.0, 'months': []},
    {
      'quarter': 'Q4',
      'total': 0.0,
      'months': [
        {'month': 'December', 'amount': 0.0},
        {'month': 'November', 'amount': 4500.0},
        {'month': 'October', 'amount': 0.0}
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.s16),
      child: SizedBox(
        height: ScreenUtil.defaultSize.height / 1.15,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Title**
              Text(
                AppStrings.incomeText,
                style: AppTextStyles.helveticaNeue(
                    AppColors.black, FontWeight.bold, AppSizes.s18.r),
              ),
              const SizedBox(height: AppSizes.s12),

              /// **Year Picker**
              const Center(child: YearPickerButton()),
              const SizedBox(height: AppSizes.s16),

              /// **Total Invoice**
              const TotalInvoiceAmount(amount: 4500.00, title: "Total"),

              /// **Quarterly Sections**
              ...quarterlyData.map((qData) => buildQuarterSection(
                    qData['quarter'],
                    qData['total'],
                    qData['months'],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
