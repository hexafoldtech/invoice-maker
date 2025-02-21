import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/app_text_styles.dart';
import '../widgets/custom_floating_button.dart';

class NewEstimateScreen extends StatelessWidget {
  const NewEstimateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.only(top: AppSizes.s15.r, left: AppSizes.s8.r),
            child: appBarLeadingAndActionsText(
                AppStrings.cancelText, AppColors.black, FontWeight.normal),
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: appBarLeadingAndActionsText(
                AppStrings.previewText, AppColors.black, FontWeight.normal),
          ),
          TextButton(
            onPressed: () {},
            child: appBarLeadingAndActionsText(
                AppStrings.doneText, AppColors.black, FontWeight.w500),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingButton(
          padding: EdgeInsets.only(bottom: AppSizes.s20.r),
          text: AppStrings.createEstimate,
          onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Text appBarLeadingAndActionsText(
      String title, Color color, FontWeight fontWeight) {
    return Text(
      title,
      style: AppTextStyles.helveticaNeueSmall(color, fontWeight),
    );
  }
}
