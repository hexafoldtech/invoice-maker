import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts_styles.dart';
import '../../constants/app_sizes.dart';
import '../app_text_styles.dart';

extension UnitTypeExtension on List {
  List<Widget> addUnitTypeItems(
      List<String> unitTypeOptions, ValueChanged<String> onSelect) {
    return [
      ...this,
      for (var entry in unitTypeOptions)
        Column(
          children: [
            const Divider(),
            GestureDetector(
              onTap: () {
                if (!entry.contains(AppStrings.cancelText)) {
                  onSelect(entry);
                } else {
                  onSelect(AppStrings.optionalText);
                }
              },
              child: Text(
                entry,
                style: AppTextStyles.helveticaNeue(
                    AppColors.blue, FontWeightStyles.medium, AppSizes.s23.r),
              ),
            ),
          ],
        ),
    ];
  }
}
