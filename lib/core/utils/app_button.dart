import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';

enum ButtonType { elevated, invoice, selectTimer, export }

class AppButton extends StatelessWidget {
  final ButtonType type;
  final String label;
  final Widget? iconLabel;
  final Color? backgroundColor;
  final Color borderColor;
  final Color textColor;
  final VoidCallback action;
  final double fontSize;
  final IconData? icon;
  final double? buttonWidth;
  final double? buttonHeight;
  final String? iconString;
  const AppButton(
      {super.key,
      required this.type,
      required this.label,
      this.iconLabel,
      this.backgroundColor,
      this.borderColor = Colors.white,
      this.textColor = Colors.white,
      this.fontSize = 8,
      required this.action,
      this.icon,
      this.buttonWidth = 296,
      this.buttonHeight = 48,
      this.iconString});
  @override
  Widget build(BuildContext context) {
    if (type == ButtonType.elevated) {
      return buildElevatedButton(context);
    } else if (type == ButtonType.invoice) {
      return createInvoiceButton(context);
    } else if (type == ButtonType.selectTimer) {
      return selectYearButton(context);
    } else if (type == ButtonType.export) {
      return exportInvoiceButton(context);
    } else {
      return buildIconButton(context);
    }
  }

  Widget buildElevatedButton(BuildContext context) {
    return Container(
      width: 296.r,
      height: 48.r,
      padding: const EdgeInsets.only(bottom: 1.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          side: BorderSide(
            width: 1.0,
            color: borderColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        onPressed: action,
        child: Text(
          label,
          style: AppTextStyles.helveticaNeue(textColor, FontWeight.w900, fontSize),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildIconButton(BuildContext context) {
    return SizedBox(
      width: AppSizes.s10.r,
    );
  }

  Widget createInvoiceButton(BuildContext context) {
    return SizedBox(
      width: AppSizes.s300.r,
      height: AppSizes.s48.r,
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          // Text color
          padding: const EdgeInsets.all(AppSizes.s10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s20),
          ),
          elevation: 8, // Shadow depth
          side: BorderSide(color: borderColor, width: AppSizes.s2),
          shadowColor: AppColors.black.withOpacity(0.5),
        ),
        child: Text(
          label,
          style: AppTextStyles.helveticaNeue(textColor, FontWeight.w900, fontSize),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget selectYearButton(BuildContext context) {
    return SizedBox(
      child: OutlinedButton(
        onPressed: action,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s20),
          ),
          side: const BorderSide(color: AppColors.darkGrey),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today,
                size: AppSizes.s20, color: AppColors.black),
            const SizedBox(width: AppSizes.s8),
            Text(
              label,
              style: const TextStyle(
                  color: AppColors.black, fontSize: AppSizes.s16),
            ),
          ],
        ),
      ),
    );
  }

  Widget exportInvoiceButton(BuildContext context) {
    return SizedBox(
      width: AppSizes.s300.r,
      height: AppSizes.s48.r,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          // Text color
          padding: const EdgeInsets.all(AppSizes.s10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s20),
          ),
          elevation: 8, // Shadow depth
          side: BorderSide(color: borderColor, width: AppSizes.s2),
          shadowColor: AppColors.black.withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.import_export_sharp,
                size: AppSizes.s20, color: AppColors.white),
            const SizedBox(width: AppSizes.s8),
            Text(
              label,
              style: AppTextStyles.helveticaNeue(textColor, FontWeight.w900, fontSize),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
