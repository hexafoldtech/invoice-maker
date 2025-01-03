import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/view/dashboard_screen/toggle_button.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(AppStrings.invoiceTabText,
                style: AppTextStyles.helveticaNeueLarge(
                    AppColors.black, FontWeight.bold)),
            const ToggleButton(),
            const SizedBox(
              height: AppSizes.s11,
            ),
          ],
        ),
      ),
    );
  }
}
