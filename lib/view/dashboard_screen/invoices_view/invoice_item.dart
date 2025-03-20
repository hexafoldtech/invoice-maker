import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_fonts_styles.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/core/utils/extensions/number_formatter.dart';
import 'package:invoice_maker/core/utils/extensions/string_formatter.dart';

class InvoiceItem extends StatelessWidget {
  final bool paid;
  final String clientName;
  final String id;
  final String date;
  final double price;
  final VoidCallback? onTap;
  final double? paidAmount;
  const InvoiceItem(
      {super.key,
      required this.paid,
      required this.clientName,
      required this.date,
      required this.price,
      required this.id,
      this.onTap,
      this.paidAmount});

  @override
  Widget build(BuildContext context) {
    String calculateDiff() {
      final diff = DateTime.now().difference(date.toDateTime()).inDays;
      var dueIn = '${AppStrings.duePreviewText} ${diff.abs()}d';
      return dueIn;
    }

    String dueIn = calculateDiff();

    return ListTile(
        title: Text(clientName,
            style: AppTextStyles.helveticaNeue(AppColors.black,
                FontWeightStyles.semiBold, AppSizes.s14.r)), // Main title
        subtitle: Text('$id, $date',
            style: AppTextStyles.helveticaNeue(
                AppColors.grey, FontWeightStyles.regular, AppSizes.s12.r)),
        trailing: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("₹ ${price.formatWithCommas()}",
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
                      ? Text(AppStrings.toggleButtonPaidText,
                          style: AppTextStyles.helveticaNeue(AppColors.darkGrey,
                              FontWeightStyles.regular, AppSizes.s11.r))
                      : Text(dueIn,
                          style: AppTextStyles.helveticaNeue(AppColors.darkGrey,
                              FontWeightStyles.regular, AppSizes.s11.r)),
                ),
              )
            ]), // Icon on the right
        onTap: onTap ?? () {});
  }
}
