import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/view/dashboard_screen/estimates_screen/estimates_item.dart';
import 'package:invoice_maker/view/dashboard_screen/total_recieved_amount.dart';

class EstimatesScreen extends StatelessWidget {
  const EstimatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(AppStrings.estimatesTabText,
                style: AppTextStyles.helveticaNeueLarge(
                    AppColors.black, FontWeight.bold)),
            const SizedBox(
              height: AppSizes.s11,
            ),
            const TotalReceivedAmount(title: AppStrings.total, amount: 5000.00),
            const SizedBox(
              height: AppSizes.s5,
            ),
            SizedBox(
              height: AppSizes.s400,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const EstimatesItem();
                },
              ),
            ),
            const SizedBox(
              height: AppSizes.s11,
            ),
            const SizedBox(
              height: AppSizes.s5,
            )
          ],
        ),
      ),
    );
  }
}
