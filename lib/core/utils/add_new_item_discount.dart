import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/item_provider.dart';
import '../constants/app_sizes.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts_styles.dart';
import '../constants/app_strings.dart';
import 'custom_text_form_field.dart';
import 'text_form_validator.dart';
import 'app_text_styles.dart';
import 'switch_button.dart';

/// widget for building discount section in add new item
class AddNewItemDiscountSection {
  bool isDiscountEnabled;
  final String selectedDiscountType;
  final ValueChanged<String> onSelectDiscountType;
  final TextEditingController discountController;
  final bool showDiscountTypeRow;
  final BuildContext ctx;
  AddNewItemDiscountSection({
    required this.ctx,
    required this.isDiscountEnabled,
    required this.discountController,
    required this.showDiscountTypeRow,
    required this.selectedDiscountType,
    required this.onSelectDiscountType,
  });
  Widget buildDiscountSection() {
    var itemProvider = Provider.of<ItemProvider>(ctx, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSizes.s16.r),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(AppStrings.discountText),
            isDiscountEnabled
                ? Text("${AppStrings.rupeeSymbolText} ${itemProvider.discount}")
                : const SizedBox.shrink(),
          ],
        ),
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
                  validator: itemProvider.isDiscountEnabled
                      ? TextFormValidator.validate
                      : null,
                  onChanged: (p0) {
                    itemProvider
                        .calculateDiscount(ctx);
                  },
                  onEditingComplete: () {
                    itemProvider.calculateDiscount(ctx);
                  },
                ),
              ),
              SwitchButton(
                value: isDiscountEnabled,
                onChanged: (value) {
                  itemProvider.toggleDiscountSwitchVisibility(value);
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
          _buildDiscountTypeOption(AppStrings.percentSymbolText),
          _buildDiscountTypeOption(AppStrings.rupeeSymbolText),
        ],
      ),
    );
  }

  Widget _buildDiscountTypeOption(String symbol) {
    final bool isSelected = selectedDiscountType == symbol;
    var itemProvider = Provider.of<ItemProvider>(ctx, listen: false);

    return GestureDetector(
      onTap: () {
        onSelectDiscountType(symbol);
        itemProvider.calculateDiscount(ctx);
      },
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
