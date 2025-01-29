import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';

class Summary extends StatelessWidget {
  final double amount;
  const Summary({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppStrings.summaryText),
        const SizedBox(height: AppSizes.s4),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  AppStrings.totalCapitalText,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    DropdownButton<String>(
                      value: 'INR',
                      items: ['INR', 'USD', 'EUR']
                          .map((currency) => DropdownMenuItem<String>(
                                value: currency,
                                child: Text(currency),
                              ))
                          .toList(),
                      onChanged: (value) {
                        // Handle currency change
                      },
                    ),
                    const SizedBox(width: AppSizes.s8),
                    Text(
                      '₹ $amount',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
