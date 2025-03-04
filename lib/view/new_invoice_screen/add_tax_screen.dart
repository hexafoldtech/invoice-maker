import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_fonts_styles.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/constants/global_key.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/core/utils/custom_text_form_field.dart';
import 'package:invoice_maker/providers/invoice_provider.dart';
import 'package:provider/provider.dart';

class AddTaxScreen extends StatefulWidget {
  const AddTaxScreen({super.key});

  @override
  State<AddTaxScreen> createState() => _AddTaxScreenState();
}

class _AddTaxScreenState extends State<AddTaxScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<InvoiceProvider>(context, listen: false).initListners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: AppSizes.s70,
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
      body: Consumer<InvoiceProvider>(
        builder: (context, invoiceProvider, child) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: AppSizes.s30.r),
                child: Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) {
                      // Re-append "%" when editing is done
                      if (!invoiceProvider.taxController.text.endsWith('%') &&
                          invoiceProvider.taxController.text.isNotEmpty) {
                        invoiceProvider.taxController.text =
                            "${invoiceProvider.taxController.text}%";
                        invoiceProvider.taxController.selection =
                            TextSelection.fromPosition(
                          TextPosition(
                              offset:
                                  invoiceProvider.taxController.text.length),
                        );
                      }
                    } else {
                      // Remove "%" when user starts editing
                      invoiceProvider.taxController.text = invoiceProvider
                          .taxController.text
                          .replaceAll('%', '');
                    }
                  },
                  child: CustomTextFormField(
                    formType: FormType.item,
                    textInputType: TextInputType.number,
                    controller: invoiceProvider.taxController,
                    hintText: '0%',
                  ),
                ),
              ),
              if (invoiceProvider.showTaxTypeRow)
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
    var invoiceProvider = Provider.of<InvoiceProvider>(
        navigatorKey.currentContext!,
        listen: false);
    final bool isSelected = invoiceProvider.selectedTaxType == type;

    return GestureDetector(
      onTap: () {
        invoiceProvider.updateTaxType(type);
        invoiceProvider;
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
