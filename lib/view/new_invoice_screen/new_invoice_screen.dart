import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_button.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/view/new_invoice_screen/client_section.dart';
import 'package:invoice_maker/view/new_invoice_screen/invoice_issued_due_section.dart';
import 'package:invoice_maker/view/new_invoice_screen/item_section.dart';
import 'package:invoice_maker/view/new_invoice_screen/summary.dart';

class NewInvoiceScreen extends StatefulWidget {
  const NewInvoiceScreen({super.key});

  @override
  _NewInvoiceScreenState createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: appBarLeadingAndActionsText(
              AppStrings.cancelText, AppColors.darkGrey, FontWeight.normal),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: appBarLeadingAndActionsText(
                AppStrings.previewText, AppColors.darkGrey, FontWeight.normal),
          ),
          TextButton(
            onPressed: () {},
            child: appBarLeadingAndActionsText(
                AppStrings.doneText, AppColors.black, FontWeight.normal),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              AppStrings.newInvoiceText,
              style: AppTextStyles.helveticaNeueMedium(
                  AppColors.black, FontWeight.bold),
            ),
            const SizedBox(
              height: AppSizes.s20,
            ),
            const Padding(
              padding: EdgeInsets.all(AppSizes.s16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InvoiceIssuedDueSection(
                    issuedDate: '9 JAN 2025',
                    dueDate: '-',
                    id: '001',
                  ),
                  SizedBox(
                    height: AppSizes.s20,
                  ),
                  ClientSection(),
                  SizedBox(
                    height: AppSizes.s20,
                  ),
                  ItemSection(),
                  SizedBox(
                    height: AppSizes.s20,
                  ),
                  Summary(amount: 15.00),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(
            type: ButtonType.invoice,
            label: AppStrings.createInvoice,
            action: () {},
            textColor: AppColors.white,
            fontSize: AppSizes.s20,
            borderColor: AppColors.white,
            backgroundColor: AppColors.black,
          ),
          const SizedBox(
            height: AppSizes.s10,
          ),
        ],
      ),
    );
  }

  Text appBarLeadingAndActionsText(
      String title, Color color, FontWeight fontWeight) {
    return Text(
      title,
      style: AppTextStyles.helveticaNeueSmall(color, fontWeight),
    );
  }
}
