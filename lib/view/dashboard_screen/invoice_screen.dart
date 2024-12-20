import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/view/dashboard_screen/bottom_nav.dart';
import 'package:invoice_maker/view/dashboard_screen/elevated_button.dart';
import 'package:invoice_maker/view/dashboard_screen/toggle_button.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              AppStrings.invoiceTabText,
              style: TextStyle(
                fontSize: AppSizes.s49,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            ToggleButton(),
            SizedBox(
              height: AppSizes.s11,
            ),
            CreateInvoiceButton(),
            SizedBox(
              height: AppSizes.s11,
            ),
            BottomNavigation()
          ],
        ),
      ),
    );
  }
}
