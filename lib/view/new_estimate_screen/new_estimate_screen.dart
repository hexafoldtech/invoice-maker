import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_floating_button.dart';

class NewEstimateScreen extends StatelessWidget {
  const NewEstimateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarType: AppBarType.create,
        onCancel: () => Navigator.pop(context),
      ),
      floatingActionButton: CustomFloatingButton(
          padding: EdgeInsets.only(bottom: AppSizes.s20.r),
          text: AppStrings.createEstimate,
          onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
