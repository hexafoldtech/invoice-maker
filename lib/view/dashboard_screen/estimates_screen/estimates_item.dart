import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';

class EstimatesItem extends StatelessWidget {
  const EstimatesItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Icon on the left
      title: const Text(
        'Quantum',
        style: TextStyle(fontWeight: FontWeight.bold),
      ), // Main title
      subtitle: const Text('#EST1,2 Jan'), // Subtext
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "\$ 4500.00",
            style: AppTextStyles.helveticaNeueItem(
                AppColors.darkGrey, FontWeight.bold),
          ),
        ],
      ), // Icon on the right
      onTap: () {},
    );
  }
}
