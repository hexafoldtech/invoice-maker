import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_button.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/core/utils/switch_button.dart';

class NewItemScreen extends StatelessWidget {
  const NewItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            AppStrings.cancelText,
            style: TextStyle(color: AppColors.black),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              AppStrings.doneText,
              style: TextStyle(color: AppColors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.s16),
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
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.grey.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(AppSizes.s8),
                        color: AppColors.white),
                    child: const Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: AppStrings.nameText,
                            border: InputBorder.none,
                          ),
                        ),
                        SizedBox(height: AppSizes.s5),
                        TextField(
                          decoration: InputDecoration(
                            labelText: AppStrings.detailsCompletedText,
                            border: InputBorder.none,
                          ),
                        ),
                        SizedBox(height: AppSizes.s5),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.saveToCatalogText,
                      ),
                      SwitchButton(
                        isOn: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.s16),
                  Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppStrings.unitPriceText),
                          Text(AppStrings.quantityText),
                          Text(AppStrings.unitTypeText),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSizes.s8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.grey.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                            color: AppColors.white),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: AppSizes.s80,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "Rs 1",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.s40,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "1",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.s80,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "Optional",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.s16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(AppStrings.discountText),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSizes.s8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.grey.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                            color: AppColors.white),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: AppSizes.s80,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "0",
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SwitchButton(
                              isOn: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.s16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.taxableText),
                      SwitchButton(
                        isOn: true,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.s34,
                  ),
                  AppButton(
                    type: ButtonType.invoice,
                    label: AppStrings.addItemText,
                    action: () {},
                    textColor: AppColors.white,
                    fontSize: AppSizes.s20,
                    borderColor: AppColors.white,
                    backgroundColor: AppColors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
