import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_text_styles.dart';
import '../constants/app_sizes.dart';
import '../constants/app_colors.dart';

class ClientTextFormField extends StatelessWidget {
  final String title;
  final TextInputType textFormType;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const ClientTextFormField(
      {super.key,
      required this.title,
      required this.textFormType,
      required this.controller,
      required this.hintText,
      this.validator});

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
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
        ],
      ),
    );
  }
}
