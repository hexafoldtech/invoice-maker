import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts_styles.dart';
import '../constants/app_strings.dart';
import 'custom_text_form_field.dart';
import 'switch_button.dart';

/// widget for building discount section in add new item
class AddNewItemDiscountSection {
  bool isDiscountEnabled;
  final String selectedDiscountType;
  final ValueChanged<String> onSelectDiscountType;
  final TextEditingController discountController;
  final bool showDiscountTypeRow;

  AddNewItemDiscountSection({
    required this.isDiscountEnabled,
    required this.discountController,
    required this.showDiscountTypeRow,
    required this.selectedDiscountType,
    required this.onSelectDiscountType,
  });

  Widget buildDiscountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSizes.s16.r),
        const Text(AppStrings.discountText),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  formType: FormType.item,
                  textInputType: TextInputType.number,
                  controller: discountController,
                  hintText: '0',
                  isEnabled: isDiscountEnabled,
                ),
              ),
              SwitchButton(
                value: isDiscountEnabled,
                onChanged: (value) {
                  isDiscountEnabled = value;
                },
              )
            ],
          ),
        ),
        if (showDiscountTypeRow)
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 8.r),
              child: _buildDiscountTypeSelector(),
            ),
          ),
        SizedBox(height: AppSizes.s16.r),
      ],
    );
  }

  Widget _buildDiscountTypeSelector() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s8.r),
        border: Border.all(color: AppColors.grey),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDiscountTypeOption(AppStrings.rupeeSymbolText),
          _buildDiscountTypeOption(AppStrings.percentSymbolText),
        ],
      ),
    );
  }

  Widget _buildDiscountTypeOption(String symbol) {
    final bool isSelected = selectedDiscountType == symbol;

    return GestureDetector(
      onTap: () => onSelectDiscountType(symbol),
      child: Container(
        width: AppSizes.s100.r,
        height: AppSizes.s30.r,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkBlueShade : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.s6.r),
        ),
        child: Center(
          child: Text(
            symbol,
            style: AppTextStyles.helveticaNeue(
              isSelected ? AppColors.white : AppColors.black,
              FontWeightStyles.regular,
              AppSizes.s14.r,
            ),
          ),
        ),
      ),
    );
  }
}
