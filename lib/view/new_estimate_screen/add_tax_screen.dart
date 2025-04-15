import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/estimate_provider.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/custom_text_form_field.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts_styles.dart';
import "../../core/constants/app_sizes.dart";
import '../../core/constants/app_strings.dart';
import '../../core/constants/global_key.dart';

class AddTaxEstimateScreen extends StatefulWidget {
  const AddTaxEstimateScreen({super.key});

  @override
  State<AddTaxEstimateScreen> createState() => _AddTaxEstimateScreenState();
}

class _AddTaxEstimateScreenState extends State<AddTaxEstimateScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<EstimateProvider>(context, listen: false).initListners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leadingWidth: AppSizes.s70.r,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              Icon(
                Icons.arrow_back,
                size: AppSizes.s22.r,
              ),
              SizedBox(
                width: AppSizes.s5.r,
              ),
              Text(
                "Back",
                style: AppTextStyles.helveticaNeue(
                    AppColors.black, FontWeightStyles.regular, AppSizes.s16.r),
              )
            ],
          ),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.s90.r),
          child: Text(
            "Tax",
            style: AppTextStyles.helveticaNeue(
                AppColors.black, FontWeightStyles.bold, AppSizes.s18.r),
          ),
        ),
      ),
      body: Consumer<EstimateProvider>(
        builder: (context, estimateProvider, child) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: AppSizes.s30.r),
                child: Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) {
                      // Re-append "%" when editing is done
                      if (!estimateProvider.taxController.text.endsWith('%') &&
                          estimateProvider.taxController.text.isNotEmpty) {
                        estimateProvider.taxController.text =
                            "${estimateProvider.taxController.text}%";
                        estimateProvider.taxController.selection =
                            TextSelection.fromPosition(
                          TextPosition(
                              offset:
                                  estimateProvider.taxController.text.length),
                        );
                      }
                    } else {
                      // Remove "%" when user starts editing
                      estimateProvider.taxController.text = estimateProvider
                          .taxController.text
                          .replaceAll('%', '');
                    }
                  },
                  child: CustomTextFormField(
                    formType: FormType.item,
                    textInputType: TextInputType.number,
                    controller: estimateProvider.taxController,
                    hintText: '0%',
                  ),
                ),
              ),
              if (estimateProvider.showTaxTypeRow)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.r),
                    child: _buildDiscountTypeSelector(),
                  ),
                )
            ],
          );
        },
      ),
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
          _buildDiscountTypeOption(AppStrings.inclusiveText),
          _buildDiscountTypeOption(AppStrings.exclusiveText),
        ],
      ),
    );
  }

  Widget _buildDiscountTypeOption(String type) {
    var estimateProvider = Provider.of<EstimateProvider>(
        navigatorKey.currentContext!,
        listen: false);
    final bool isSelected = estimateProvider.selectedTaxType == type;

    return GestureDetector(
      onTap: () {
        estimateProvider.updateTaxType(type);
        estimateProvider;
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
            type,
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

  @override
  void dispose() {
    super.dispose();
  }
}
