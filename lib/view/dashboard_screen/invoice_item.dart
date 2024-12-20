import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';

class InvoiceItem extends StatelessWidget {
  final String paid;

  const InvoiceItem({super.key, required this.paid});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Icon on the left
      title: const Text(
        'Mrinangka',
        style: TextStyle(fontWeight: FontWeight.bold),
      ), // Main title
      subtitle: const Text('Flutter'), // Subtext
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "\$ 4500.00",
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: AppSizes.s18),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.s4),
              color: AppColors.green.withOpacity(0.5),
            ),
            padding: const EdgeInsets.all(
                AppSizes.s5), // Adds space inside the boundary
            // Optional background for visibility
            child: Text(
              paid,
              style: const TextStyle(
                fontSize: AppSizes.s11,
              ),
            ),
          )
        ],
      ), // Icon on the right
      onTap: () {},
    );
  }
}
