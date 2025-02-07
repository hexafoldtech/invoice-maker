import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/view/dashboard_screen/invoices_view/toggle_button.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      SizedBox(height: AppSizes.s15.r),
      Text(AppStrings.invoiceTabText,
          style: AppTextStyles.helveticaNeue(
              AppColors.black, FontWeight.bold, AppSizes.s30.r)),
      const ToggleButton(),
      SizedBox(height: AppSizes.s11.r)
    ]));
  }
}
