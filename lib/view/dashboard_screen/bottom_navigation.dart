import 'package:flutter/material.dart';

import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
