import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/view/dashboard_screen/invoices_view/invoice_item.dart';
import 'package:invoice_maker/view/dashboard_screen/estimates_view/total_recieved_amount.dart';

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
    return Column(children: [
      /// [custom toggle buttons] for polished UI
      Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.s25.r),
          color: Colors.grey[300],
        ),
        child: ToggleButtons(
          borderRadius: BorderRadius.circular(AppSizes.s20.r),
          borderWidth: 0,
          borderColor: Colors.transparent,
          selectedBorderColor: Colors.transparent,
          selectedColor: Colors.black,
          fillColor: Colors.transparent,
          constraints: BoxConstraints(
            minHeight: AppSizes.s30.r,
            minWidth: AppSizes.s60.r,
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
            _toggleButtonItem(AppStrings.toggleButtonUnpaidText, isSelected[1]),
            _toggleButtonItem(AppStrings.toggleButtonPaidText, isSelected[2]),
          ],
        ),
      ),
      SizedBox(height: AppSizes.s10.r),
      const TotalReceivedAmount(title: AppStrings.total, amount: 4500.00),
      const TotalReceivedAmount(title: AppStrings.received, amount: 4500.00),
      SizedBox(
          height: AppSizes.s400.r,
          child: IndexedStack(index: selectedIndex, children: [
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
                })
          ]))
    ]);
  }

  /// individual [toggleButtonItem] with animation 
  Widget _toggleButtonItem(String text, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.white
            : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSizes.s20.r),
        boxShadow: isSelected
            ? [
                const BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: AppSizes.s14.r,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
