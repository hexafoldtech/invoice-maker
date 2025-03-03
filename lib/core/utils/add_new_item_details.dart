import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts_styles.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';
import 'extensions/unit_type_calculator.dart';
import 'app_text_styles.dart';
import 'bottom_sheet.dart';
import 'custom_text_form_field.dart';
import 'text_form_validator.dart';

/// widget for building item details section in add new item
class AddNewItemDetailsSection {
  final TextEditingController moneyController;
  final TextEditingController quantityController;
  final Function(String) moneyFieldOnChanged;
  final VoidCallback clearMoneyField;
  final List<String> unitTypeOptions;
  final String unitType;
  final Function(String) updateUnitType;
  final BuildContext context;

  AddNewItemDetailsSection({
    required this.moneyController,
    required this.quantityController,
    required this.moneyFieldOnChanged,
    required this.clearMoneyField,
    required this.unitType,
    required this.unitTypeOptions,
    required this.updateUnitType,
    required this.context,
  });

  Widget buildUnitSection() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.unitPriceText),
            Text(AppStrings.quantityText),
            Text(AppStrings.unitTypeText),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPriceInput(),
              _buildQuantityInput(),
              _buildUnitTypeSelector(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceInput() {
    return Row(
      children: [
        Text(
          "₹",
          style: AppTextStyles.helveticaNeue(
            AppColors.black,
            FontWeightStyles.regular,
            AppSizes.s15.r,
          ),
        ),
        SizedBox(
          width: AppSizes.s70.r,
          child: CustomTextFormField(
            formType: FormType.item,
            textInputType: TextInputType.number,
            controller: moneyController,
            hintText: '1',
            onChanged: moneyFieldOnChanged,
            validator: TextFormValidator.validate,
          ),
        ),
        SizedBox(
          width: AppSizes.s10.r,
          child: moneyController.text.isNotEmpty
              ? GestureDetector(
                  onTap: clearMoneyField,
                  child: Icon(
                    Icons.clear,
                    size: AppSizes.s16.r,
                    color: AppColors.grey,
                  ),
                )
              : const SizedBox.shrink(),
        )
      ],
    );
  }

  Widget _buildQuantityInput() {
    return SizedBox(
      width: AppSizes.s80.r,
      child: CustomTextFormField(
        formType: FormType.item,
        textInputType: TextInputType.number,
        controller: quantityController,
        hintText: '1',
        validator: TextFormValidator.validate,
      ),
    );
  }

  Widget _buildUnitTypeSelector() {
    return GestureDetector(
      onTap: () {
        CustomBottomSheet(
          type: CustomBottomSheetType.floating,
          header: const Text(AppStrings.unitTypeText),
          floatingHeight: AppSizes.s250.r,
          mainContent: Column(
            children: [].addUnitTypeItems(unitTypeOptions, (unitType) {
              if (unitType != AppStrings.cancelText) {
                updateUnitType(unitType);
              }
              Navigator.pop(context);
            }),
          ),
        ).showCustomBottomSheet();
      },
      child: Container(
        width: AppSizes.s70.r,
        decoration: BoxDecoration(
          border: Border.all(width: AppSizes.s1),
          borderRadius: BorderRadius.circular(AppSizes.s20.r),
        ),
        child: Center(
          child: Text(
            unitType,
            style: AppTextStyles.helveticaNeue(
              unitType.contains(AppStrings.optionalText)
                  ? AppColors.grey
                  : AppColors.black,
              FontWeightStyles.regular,
              AppSizes.s15.r,
            ),
          ),
        ),
      ),
    );
  }
}
