import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/view/dashboard_screen/invoice_item.dart';
import 'package:invoice_maker/view/dashboard_screen/total_recieved_amount.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  List<bool> isSelected = [true, false, false];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleButtons(
          borderRadius: BorderRadius.circular(AppSizes.s8),
          borderColor: AppColors.darkGrey,
          selectedBorderColor: AppColors.black,
          selectedColor: AppColors.white,
          fillColor: AppColors.black,
          color: AppColors.black,
          constraints: const BoxConstraints(
            minHeight: AppSizes.s35,
            minWidth: AppSizes.s70,
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
          children: const [
            Text(AppStrings.toggleButtonAllText),
            Text(AppStrings.toggleButtonUnpaidText),
            Text(AppStrings.toggleButtonPaidText),
          ],
        ),
        const SizedBox(
          height: AppSizes.s20,
        ),
        const TotalReceivedAmount(title: AppStrings.total, amount: 4500.00),
        const SizedBox(
          height: AppSizes.s5,
        ),
        const TotalReceivedAmount(title: AppStrings.received, amount: 4500.00),
        SizedBox(
          height: AppSizes.s400,
          child: IndexedStack(
            index: selectedIndex,
            children: [
              ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const InvoiceItem(
                    paid: "Paid",
                  );
                },
              ),
              ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const InvoiceItem(
                    paid: "Unpaid",
                  );
                },
              ),
              ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const InvoiceItem(
                    paid: "Paid",
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
