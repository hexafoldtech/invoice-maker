import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/core/utils/total_invoice_amount.dart';
import 'package:invoice_maker/core/utils/year_picker.dart';

class ReportsScreens extends StatelessWidget {
  const ReportsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Text(AppStrings.incomeText,
          style: AppTextStyles.helveticaNeueMedium(
              AppColors.black, FontWeight.bold)),
      const SizedBox(height: AppSizes.s11),
      const YearPickerButton(),
      const TotalInvoiceAmount(amount: 4500.00, title: "Total"),
      buildQuarterSection('Q4', '₹ 4,500.00', [
        {'month': 'December', 'amount': '₹ 0.00'},
        {'month': 'November', 'amount': '₹ 4,500.00'},
        {'month': 'October', 'amount': '₹ 0.00'}
      ]),
      buildQuarterSection('Q3', '₹ 0.00', []),
      buildQuarterSection('Q2', '₹ 0.00', []),
      buildQuarterSection('Q1', '₹ 0.00', [])
    ]));
  }
}
