import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_button.dart';
import 'package:invoice_maker/view/dashboard_screen/bottom_navigation.dart';
import 'package:invoice_maker/view/dashboard_screen/toggle_button.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text(
              AppStrings.invoiceTabText,
              style: TextStyle(
                fontSize: AppSizes.s49,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const ToggleButton(),
            const SizedBox(
              height: AppSizes.s11,
            ),
            AppButton(
              type: ButtonType.invoice,
              label: AppStrings.createInvoice,
              action: () {},
              textColor: AppColors.white,
              fontSize: AppSizes.s20,
              borderColor: AppColors.white,
              backgroundColor: AppColors.black,
            ),
            const SizedBox(
              height: AppSizes.s11,
            ),
            const BottomNavigation()
          ],
        ),
      ),
    );
  }
}
