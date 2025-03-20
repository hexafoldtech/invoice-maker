import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import "../../../providers/invoice_provider.dart";
import 'invoice_item.dart';
import '../estimates_view/total_recieved_amount.dart';
import '../../../core/definitions/route_names.dart';
import '../../../core/utils/extensions/date_formatter.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<InvoiceProvider>(context, listen: false).fetchInvoices();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceProvider>(
      builder: (context, invoiceProvider, child) {
        final paidInvoices = invoiceProvider.invoices
            .where(
                (invoice) => invoice.status == AppStrings.toggleButtonPaidText)
            .toList();
        final unpaidInvoices = invoiceProvider.invoices
            .where((invoice) =>
                invoice.status == AppStrings.toggleButtonUnpaidText)
            .toList();

        final totalAllAmount =
            invoiceProvider.invoices.fold(0.0, (sum, e) => sum + e.total);
        final totalPaidAmount =
            paidInvoices.fold(0.0, (sum, e) => sum + e.total);
        final totalUnPaidAmount =
            unpaidInvoices.fold(0.0, (sum, e) => sum + e.total);
        log("Unpaid ${totalUnPaidAmount.toString()}");
        final totalAllRecievedAmount =
            invoiceProvider.invoices.fold(0.0, (sum, e) => sum + e.paidAmount);
        final totalPaidRecievedAmount =
            paidInvoices.fold(0.0, (sum, e) => sum + e.paidAmount);
        final totalUnPaidRecievedAmount =
            unpaidInvoices.fold(0.0, (sum, e) => sum + e.paidAmount);
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
                  _toggleButtonItem(
                      AppStrings.toggleButtonAllText, isSelected[0]),
                  _toggleButtonItem(
                      AppStrings.toggleButtonUnpaidText, isSelected[1]),
                  _toggleButtonItem(
                      AppStrings.toggleButtonPaidText, isSelected[2]),
                ],
              ),
            ),
            SizedBox(height: AppSizes.s10.r),
            SizedBox(
              height: AppSizes.s400.r,
              child: IndexedStack(
                index: selectedIndex,
                children: [
                  invoiceProvider.invoices.isNotEmpty
                      ? Column(
                          children: [
                            TotalReceivedAmount(
                                title: AppStrings.total,
                                amount: totalAllAmount),
                            TotalReceivedAmount(
                                title: AppStrings.received,
                                amount: totalAllRecievedAmount),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: invoiceProvider.invoices.length,
                                  itemBuilder: (context, index) {
                                    return InvoiceItem(
                                      paid: invoiceProvider
                                              .invoices[index].status ==
                                          AppStrings.toggleButtonPaidText,
                                      clientName: invoiceProvider
                                          .invoices[index].client.clientName,
                                      date: invoiceProvider
                                          .invoices[index].dueDate
                                          .toFormattedString(),
                                      price:
                                          invoiceProvider.invoices[index].total,
                                      id: (invoiceProvider.invoices[index].id +
                                              1)
                                          .toString()
                                          .padLeft(3, '0'),
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          RouteNames.invoiceDetailsScreen,
                                          arguments: {
                                            'invoice':
                                                invoiceProvider.invoices[index]
                                          },
                                        );
                                      },
                                    );
                                  }),
                            ),
                          ],
                        )
                      : const Center(child: Text('No Invoices')),
                  unpaidInvoices.isNotEmpty
                      ? Column(
                          children: [
                            TotalReceivedAmount(
                                title: AppStrings.total,
                                amount: totalUnPaidAmount),
                            TotalReceivedAmount(
                                title: AppStrings.received,
                                amount: totalUnPaidRecievedAmount),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: unpaidInvoices.length,
                                itemBuilder: (context, index) {
                                  return InvoiceItem(
                                    paid: false,
                                    clientName:
                                        unpaidInvoices[index].client.clientName,
                                    date: unpaidInvoices[index]
                                        .dueDate
                                        .toFormattedString(),
                                    price: unpaidInvoices[index].total,
                                    id: (unpaidInvoices[index].id + 1)
                                        .toString()
                                        .padLeft(3, '0'),
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteNames.invoiceDetailsScreen,
                                        arguments: {
                                          'invoice': unpaidInvoices[index]
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : const Center(child: Text('No Invoices')),

                  // Paid Invoices
                  paidInvoices.isNotEmpty
                      ? Column(
                          children: [
                            TotalReceivedAmount(
                                title: AppStrings.yearText,
                                amount: totalPaidRecievedAmount),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: paidInvoices.length,
                                itemBuilder: (context, index) {
                                  return InvoiceItem(
                                    paid: true,
                                    clientName:
                                        paidInvoices[index].client.clientName,
                                    date: paidInvoices[index]
                                        .dueDate
                                        .toFormattedString(),
                                    price: paidInvoices[index].total,
                                    id: (paidInvoices[index].id + 1)
                                        .toString()
                                        .padLeft(3, '0'),
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteNames.invoiceDetailsScreen,
                                        arguments: {
                                          'invoice': paidInvoices[index]
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : const Center(child: Text('No Invoices')),
                ],
              ),
            ),
          ],
        );
      },
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
