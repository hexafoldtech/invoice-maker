import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';

class CreateInvoiceButton extends StatelessWidget {
  const CreateInvoiceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.s300,
      height: AppSizes.s60,
      child: ElevatedButton(
        onPressed: () {
          print(AppStrings.elevatedButtonClicked);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          // Text color
          padding: const EdgeInsets.all(AppSizes.s10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s20),
          ),
          elevation: 8, // Shadow depth
          side: const BorderSide(color: AppColors.white, width: AppSizes.s2),
          shadowColor: AppColors.black.withOpacity(0.5),
        ),
        child: Text(
          AppStrings.createInvoice,
          style:
              AppTextStyles.helveticaNeue(AppColors.white, FontWeight.normal),
        ),
      ),
    );
  }
}
