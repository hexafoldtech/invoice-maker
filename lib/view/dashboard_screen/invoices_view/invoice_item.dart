import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_fonts_styles.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';

class InvoiceItem extends StatelessWidget {
  final bool paid;

  const InvoiceItem({super.key, required this.paid});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('Quantum',
            style: AppTextStyles.helveticaNeue(AppColors.black,
                FontWeightStyles.semiBold, AppSizes.s14.r)), // Main title
        subtitle: Text('#001, 21 Nov',
            style: AppTextStyles.helveticaNeue(
                AppColors.grey, FontWeightStyles.regular, AppSizes.s12.r)),
        trailing: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("₹ 4500.00",
                  style: AppTextStyles.helveticaNeue(AppColors.black,
                      FontWeightStyles.semiBold, AppSizes.s14.r)),
              Container(
                width: paid ? AppSizes.s37.r : AppSizes.s47.r,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.s30),
                    color:
                        paid ? AppColors.lightblueShade : AppColors.lightGrey),
                child: Center(
                  child: paid
                      ? Text('Paid',
                          style: AppTextStyles.helveticaNeue(AppColors.darkGrey,
                              FontWeightStyles.regular, AppSizes.s11.r))
                      : Text('Unpaid',
                          style: AppTextStyles.helveticaNeue(AppColors.darkGrey,
                              FontWeightStyles.regular, AppSizes.s11.r)),
                ),
              )
            ]), // Icon on the right
        onTap: () {});
  }
}
