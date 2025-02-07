import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_fonts_styles.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/core/utils/extensions/string_formatter.dart';
import 'package:invoice_maker/providers/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
        builder: (context, bottomNavigationProvider, child) {
      return Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(
              vertical: AppSizes.s10.r, horizontal: AppSizes.s20.r),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: bottomNavigationProvider.bottomBarItems.map((item) {
                bool isSelected =
                    bottomNavigationProvider.selectedOption == item.label;
                return GestureDetector(
                    onTap: item.buttonAction,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Icon(item.icon,
                          color: isSelected ? Colors.black : Colors.grey),
                      SizedBox(height: AppSizes.s5.r),
                      Text(item.label.name.toString().formatString(),
                          style: AppTextStyles.helveticaNeue(
                              isSelected ? AppColors.black : AppColors.grey,
                              FontWeightStyles.regular,
                              AppSizes.s12.r))
                    ]));
              }).toList()));
    });
  }
}

class BottomBarItemsModel {
  final IconData icon;
  final BottomBarOptions label;
  final VoidCallback buttonAction;

  const BottomBarItemsModel(
      {required this.icon, required this.label, required this.buttonAction});
}
