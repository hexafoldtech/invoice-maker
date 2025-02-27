import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'invoice_item.dart';
import '../estimates_view/total_recieved_amount.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts_styles.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  List<bool> isSelected = [true, false, false];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// [custom toggle buttons] for polished UI
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.s25.r),
            color: Colors.grey[200],
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: ToggleButtons(
            borderRadius: BorderRadius.circular(AppSizes.s20.r),
            borderWidth: 0,
            renderBorder: false,
            borderColor: Colors.transparent,
            selectedBorderColor: Colors.transparent,
            selectedColor: Colors.white,
            fillColor: AppColors.transparent,
            color: Colors.grey[700],
            constraints: BoxConstraints(
              minHeight: AppSizes.s36.r,
              minWidth: AppSizes.s70.r,
            ),
            isSelected: isSelected,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  isSelected[i] = i == index;
                }
                selectedIndex = index;
              });
            },
            children: [
              _toggleButtonItem(AppStrings.toggleButtonAllText, isSelected[0]),
              _toggleButtonItem(
                  AppStrings.toggleButtonUnpaidText, isSelected[1]),
              _toggleButtonItem(AppStrings.toggleButtonPaidText, isSelected[2]),
            ],
          ),
        ),
        SizedBox(height: AppSizes.s10.r),
        const TotalReceivedAmount(title: AppStrings.total, amount: 4500.00),
        const TotalReceivedAmount(title: AppStrings.received, amount: 4500.00),
        SizedBox(
          height: AppSizes.s400.r,
          child: IndexedStack(
            index: selectedIndex,
            children: [
              ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return const InvoiceItem(paid: true);
                  }),
              ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return const InvoiceItem(paid: false);
                  }),
              ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const InvoiceItem(paid: true);
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  /// individual [toggleButtonItem] with animation
  Widget _toggleButtonItem(String text, bool isSelected) {
    return Container(
      height: AppSizes.s32.r,
      width: AppSizes.s63.r,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.darkBlueShade : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSizes.s16.r),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.s6.r),
          child: Text(
            text,
            style: AppTextStyles.helveticaNeue(
                isSelected ? AppColors.white : AppColors.darkBlueShade,
                isSelected
                    ? FontWeightStyles.semiBold
                    : FontWeightStyles.regular,
                AppSizes.s14.r),
          ),
        ),
      ),
    );
  }
}
