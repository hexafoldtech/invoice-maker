import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';

class ClientTextFormField extends StatelessWidget {
  final String title;
  final String textFormType;
  final TextEditingController controller;
  const ClientTextFormField(
      {super.key,
      required this.title,
      required this.textFormType,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.s8),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(AppSizes.s8),
          color: AppColors.white),
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.s80.r,
            child: Text(title,
                style: AppTextStyles.helveticaNeue(
                    AppColors.darkGrey, FontWeight.normal)),
          ),
          const SizedBox(width: AppSizes.s3),
          SizedBox(
            width: AppSizes.s200.r,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: textFormType,
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
