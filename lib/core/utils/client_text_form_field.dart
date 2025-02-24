import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';

class ClientTextFormField extends StatelessWidget {
  final String title;
  final TextInputType textFormType;
  final String hintText;
  final TextEditingController controller;
  const ClientTextFormField(
      {super.key,
      required this.title,
      required this.textFormType,
      required this.controller,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.s8.r),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(AppSizes.s20.r),
          color: AppColors.white),
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.s60.r,
            child: Text(title,
                style: AppTextStyles.helveticaNeue(
                    AppColors.black, FontWeight.normal, AppSizes.s12.r)),
          ),
          const SizedBox(width: AppSizes.s3),
          SizedBox(
            width: AppSizes.s200.r,
            child: TextFormField(
              keyboardType: textFormType,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
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
