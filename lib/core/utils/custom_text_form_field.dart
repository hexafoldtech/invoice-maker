import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_fonts_styles.dart';
import 'app_text_styles.dart';
import '../constants/app_sizes.dart';
import '../constants/app_colors.dart';

enum FormType { client, item }

class CustomTextFormField extends StatelessWidget {
  final FormType formType;
  final String? title;
  final TextInputType textInputType;
  final String hintText;
  final TextStyle hintTextStyle;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final bool? isEnabled;
  final FocusNode? focusNode;
  CustomTextFormField({
    super.key,
    required this.formType,
    this.title,
    required this.textInputType,
    required this.controller,
    required this.hintText,
    TextStyle? hintTextStyle,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.isEnabled,
    this.focusNode,
  }) : hintTextStyle = hintTextStyle ??
            AppTextStyles.helveticaNeue(
              AppColors.grey,
              FontWeightStyles.regular,
              AppSizes.s15.r,
            );

  @override
  Widget build(BuildContext context) {
    switch (formType) {
      case FormType.client:
        return _buildForCLient();
      case FormType.item:
        return _buildForItem();
    }
  }

  Widget _buildForCLient() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.s8.r),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(AppSizes.s10.r),
          color: AppColors.white),
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.s60.r,
            child: Text(title!,
                style: AppTextStyles.helveticaNeue(
                    AppColors.black, FontWeight.normal, AppSizes.s12.r)),
          ),
          const SizedBox(width: AppSizes.s3),
          SizedBox(
            width: AppSizes.s200.r,
            child: TextFormField(
              focusNode: focusNode,
              keyboardType: textInputType,
              controller: controller,
              enabled: isEnabled,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: hintTextStyle,
                border: InputBorder.none,
              ),
              onChanged: onChanged,
              onEditingComplete: onEditingComplete,
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForItem() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.s8.r),
      child: SizedBox(
        width: AppSizes.s60.r,
        child: TextFormField(
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          keyboardType: textInputType,
          controller: controller,
          enabled: isEnabled,
          decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: hintTextStyle),
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }
}
