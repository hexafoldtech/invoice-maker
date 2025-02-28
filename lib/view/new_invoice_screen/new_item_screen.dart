import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/utils/text_form_validator.dart';
import '../../providers/form_provider.dart';
import '../../providers/item_provider.dart';
import '../widgets/custom_floating_button.dart';
import '../../core/utils/add_new_item_details.dart';
import '../../core/utils/custom_text_form_field.dart';
import '../../core/utils/add_new_item_discount.dart';
import '../../core/utils/switch_button.dart';
import "../../core/utils/app_text_styles.dart";
import '../../core/constants/global_key.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  var ctx = navigatorKey.currentContext!;

  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<ItemProvider>(context, listen: false).initListeners();
  // }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context, listen: true);
    final formProvider = Provider.of<FormProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(AppSizes.s16),
      child: Form(
        key: formProvider.itemformKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.s10),
              Text(
                AppStrings.newItemText,
                style: AppTextStyles.helveticaNeueMedium(
                    AppColors.black, FontWeight.bold),
              ),
              const SizedBox(height: AppSizes.s20),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSizes.s10),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          formType: FormType.item,
                          textInputType: TextInputType.number,
                          controller: itemProvider.nameController,
                          hintText: AppStrings.nameText,
                          validator: TextFormValidator.validate,
                        ),
                        const SizedBox(height: AppSizes.s5),
                        CustomTextFormField(
                          formType: FormType.item,
                          textInputType: TextInputType.number,
                          controller: itemProvider.detailsController,
                          hintText: AppStrings.detailsCompletedText,
                          validator: TextFormValidator.validate,
                        ),
                        const SizedBox(height: AppSizes.s5),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        AppStrings.saveToCatalogText,
                      ),
                      SwitchButton(
                        value: itemProvider.saveToItems,
                        onChanged: (value) {
                          itemProvider.toggleSaveSwitchVisibility(value);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.s16.r),
                  AddNewItemDetailsSection(
                          moneyController: itemProvider.moneyController,
                          quantityController: itemProvider.quantityController,
                          clearMoneyField: () {
                            itemProvider.moneyController.clear();
                            setState(() {});
                          },
                          moneyFieldOnChanged: (val) {
                            setState(() {});
                          },
                          unitType: itemProvider.unitType,
                          unitTypeOptions: itemProvider.unitTypeOptions,
                          updateUnitType: itemProvider.updateUnitType,
                          context: context)
                      .buildUnitSection(),
                  AddNewItemDiscountSection(
                          ctx: ctx,
                          isDiscountEnabled: itemProvider.isDiscountEnabled,
                          discountController: itemProvider.discountController,
                          onSelectDiscountType: (value) {
                            itemProvider.updateDiscountType(value);
                          },
                          showDiscountTypeRow: itemProvider.showDiscountTypeRow,
                          selectedDiscountType:
                              itemProvider.selectedDiscountType)
                      .buildDiscountSection(),
                  Row(
                    children: [
                      const Expanded(child: Text(AppStrings.taxableText)),
                      SwitchButton(
                        value: itemProvider.isTaxable,
                        onChanged: (value) {
                          itemProvider.toggleTaxSwitchVisibility(value);
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.s35.r,
                  ),
                  CustomFloatingButton(
                      text: AppStrings.addItemText,
                      onPressed: () {
                        _onSaveItem(ctx);
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSaveItem(BuildContext ctx) {
    final itemProvider = Provider.of<ItemProvider>(ctx, listen: false);
    final newItem = itemProvider.createClientModel();
    if (Provider.of<FormProvider>(ctx, listen: false).validateItemForm()) {
      if (itemProvider.saveToItems) {
        itemProvider.addItem(newItem).then(
          (_) {
            itemProvider.selectItems(newItem);
            log(itemProvider.selectedItems.toString());
            if (ctx.mounted) {
              Navigator.pop(ctx);
              Future.delayed(
                Durations.short4,
                () {
                  if (ctx.mounted) {
                    Navigator.pop(ctx);
                  }
                },
              );
            }
            itemProvider.clearForm();
          },
        );
      } else {
        itemProvider.selectItems(newItem);
        Navigator.pop(ctx);
        Future.delayed(
          Durations.short4,
          () {
            if (ctx.mounted) {
              Navigator.pop(ctx);
            }
          },
        );
        itemProvider.clearForm();
      }
    }
  }
}
