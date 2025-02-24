import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts_styles.dart';
import '../../constants/app_sizes.dart';
import '../app_text_styles.dart';

extension DueDateExtensions on List {
  List<Widget> addDueDateItems(List<MapEntry<String, int>> dueDateOptions,
      ValueChanged<String> onSelect) {
    return [
      ...this,
      for (var entry in dueDateOptions)
        Column(
          children: [
            const Divider(),
            GestureDetector(
              onTap: () {
                // Calculate due date based on selection
                if (entry.value != -1) {
                  DateTime newDueDate =
                      DateTime.now().add(Duration(days: entry.value));
                  String formattedDate =
                      "${newDueDate.day} ${_getMonthName(newDueDate.month)} ${newDueDate.year}";
                  onSelect(formattedDate);
                } else {
                  onSelect("-");
                }
              },
              child: Text(
                entry.key,
                style: AppTextStyles.helveticaNeue(
                    AppColors.blue, FontWeightStyles.medium, AppSizes.s23.r),
              ),
            ),
          ],
        ),
    ];
  }
}

// Helper function to get month name
String _getMonthName(int month) {
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  return months[month - 1];
}
