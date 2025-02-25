import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/view/new_invoice_screen/client_section.dart';
import 'package:invoice_maker/view/new_invoice_screen/invoice_issued_due_section.dart';
import 'package:invoice_maker/view/new_invoice_screen/item_section.dart';
import 'package:invoice_maker/view/new_invoice_screen/summary.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_floating_button.dart';

class NewInvoiceScreen extends StatefulWidget {
  const NewInvoiceScreen({super.key});

  @override
  _NewInvoiceScreenState createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarType: AppBarType.create,
        onCancel: () => Navigator.pop(context),
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
      floatingActionButton: CustomFloatingButton(
          padding: EdgeInsets.only(bottom: AppSizes.s20.r),
          text: AppStrings.createInvoice,
          onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
