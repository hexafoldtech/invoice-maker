import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_button.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/core/utils/total_invoice_amount.dart';
import 'package:invoice_maker/core/utils/year_picker.dart';
import 'package:invoice_maker/providers/tab_provider.dart';
import 'package:provider/provider.dart';

class ReportsScreens extends StatelessWidget {
  const ReportsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.message),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.settings,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(AppStrings.incomeText,
                style: AppTextStyles.helveticaNeueMedium(
                    AppColors.black, FontWeight.bold)),
            const SizedBox(
              height: AppSizes.s11,
            ),
            const YearPickerButton(),
            const TotalInvoiceAmount(amount: 4500.00, title: "Total"),
            buildQuarterSection('Q4', '₹ 4,500.00', [
              {'month': 'December', 'amount': '₹ 0.00'},
              {'month': 'November', 'amount': '₹ 4,500.00'},
              {'month': 'October', 'amount': '₹ 0.00'},
            ]),
            buildQuarterSection('Q3', '₹ 0.00', []),
            buildQuarterSection('Q2', '₹ 0.00', []),
            buildQuarterSection('Q1', '₹ 0.00', []),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(
            type: ButtonType.export,
            label: AppStrings.exportInvoicesText,
            action: () {},
            textColor: AppColors.white,
            fontSize: AppSizes.s20,
            borderColor: AppColors.white,
            backgroundColor: AppColors.black,
          ),
          const SizedBox(
            height: AppSizes.s5,
          ),
        ],
      ),
    );
  }
}

// Widget buildQuarterSection(
//     String quarter, String total, List<Map<String, String>> months) {
//   return Card(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8),
//     ),
//     margin: EdgeInsets.only(top: 16),
//     child: ExpansionTile(
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             quarter,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             total,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//       children: months.isNotEmpty
//           ? months
//               .map((month) => ListTile(
//                     title: Text(month['month']!),
//                     trailing: Text(month['amount']!),
//                   ))
//               .toList()
//           : [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'No data available',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ),
//             ],
//     ),
//   );
// }
