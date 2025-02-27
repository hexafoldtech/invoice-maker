import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();

  /// default [unit type selection]
  String _unitType = AppStrings.optionalText;

  /// for showing the discount row of which type
  bool _showDiscountTypeRow = false;
  bool _saveToItems = true;
  bool _isDiscountEnabled = false;
  bool _isTaxable = false;

  String _selectedDiscountType = AppStrings.rupeeSymbolText;

  final List<String> _unitTypeOptions = [
    AppStrings.noDueDateText,
    AppStrings.hoursText,
    AppStrings.daysText,
    AppStrings.cancelText //  used to close the bottom sheet
  ];

  /// onselect update the type
  void _updateUnitType(String newUnitType) {
    setState(() {
      _unitType = newUnitType;
    });
  }

  void _checkDiscountInput() {
    setState(() {
      _showDiscountTypeRow = _discountController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _discountController.addListener(_checkDiscountInput);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  child: Column(
                    children: [
                      CustomTextFormField(
                          formType: FormType.item,
                          textInputType: TextInputType.number,
                          controller: _nameController,
                          hintText: AppStrings.nameText),
                      const SizedBox(height: AppSizes.s5),
                      CustomTextFormField(
                          formType: FormType.item,
                          textInputType: TextInputType.number,
                          controller: _detailsController,
                          hintText: AppStrings.detailsCompletedText),
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
                      value: _saveToItems,
                      onChanged: (value) {
                        _saveToItems = value;
                      },
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.s16.r),
                AddNewItemDetailsSection(
                        moneyController: _moneyController,
                        clearMoneyField: () {
                          _moneyController.clear();
                          setState(() {});
                        },
                        moneyFieldOnChanged: (val) {
                          setState(() {});
                        },
                        unitType: _unitType,
                        unitTypeOptions: _unitTypeOptions,
                        updateUnitType: _updateUnitType,
                        context: context)
                    .buildUnitSection(),
                AddNewItemDiscountSection(
                        isDiscountEnabled: _isDiscountEnabled,
                        discountController: _discountController,
                        onSelectDiscountType: (value) {
                          setState(() {
                            _selectedDiscountType = value;
                          });
                        },
                        showDiscountTypeRow: _showDiscountTypeRow,
                        selectedDiscountType: _selectedDiscountType)
                    .buildDiscountSection(),
                Row(
                  children: [
                    const Expanded(child: Text(AppStrings.taxableText)),
                    SwitchButton(
                      value: _isTaxable,
                      onChanged: (value) {
                        _isTaxable = value;
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: AppSizes.s35.r,
                ),
                CustomFloatingButton(
                    text: AppStrings.addItemText, onPressed: () {})
              ],
            ),
          ],
        ),
      ),
    );
  }
}
