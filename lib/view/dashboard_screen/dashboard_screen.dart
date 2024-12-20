import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/view/dashboard_screen/invoice_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: AppStrings.invoiceMakerText),
              Tab(text: AppStrings.estimatesTabText),
            ],
            labelStyle: TextStyle(
              fontSize: AppSizes.s19,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: AppSizes.s19,
              fontWeight: FontWeight.normal,
              color: AppColors.darkGrey,
            ),
            indicatorColor: AppColors.black,
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: InvoiceScreen()),
            Center(child: Text('Content for Tab 2')),
          ],
        ),
      ),
    );
  }
}
