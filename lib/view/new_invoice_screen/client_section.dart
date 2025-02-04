import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/view/new_invoice_screen/client_screen.dart';

class ClientSection extends StatelessWidget {
  const ClientSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppStrings.clientText,
            style: TextStyle(fontSize: AppSizes.s16)),
        const SizedBox(height: AppSizes.s8),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ClientScreen(),
                ));
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSizes.s16),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(AppSizes.s8),
                color: AppColors.white),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                Text(AppStrings.addClientText,
                    style: TextStyle(
                        fontSize: AppSizes.s16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
