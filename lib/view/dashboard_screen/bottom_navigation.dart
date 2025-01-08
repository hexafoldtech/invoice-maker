import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/providers/bottom_navigation_provider.dart';
import 'package:invoice_maker/view/dashboard_screen/dashboard_screen.dart';
import 'package:invoice_maker/view/dashboard_screen/reports_screen/reports_screens.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavigationProvider =
        Provider.of<BottomNavigationProvider>(context);
    return Scaffold(
      body: bottomNavigationProvider.currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavigationProvider.currentIndex,
        onTap: (index) => bottomNavigationProvider.updateIndex(index),
        elevation: AppSizes.s0,
        selectedItemColor: AppColors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: AppStrings.invoiceTabText,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: AppStrings.reportBottomNavTabText,
          ),
        ],
      ),
    );
  }
}
