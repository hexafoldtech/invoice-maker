import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:invoice_maker/core/constants/app_fonts_styles.dart';
import 'package:invoice_maker/providers/client_provider.dart';
import 'package:provider/provider.dart';
import 'client_screen.dart';
import 'item_screen.dart';
import 'summary.dart';
import 'invoice_issued_due_section.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_floating_button.dart';
import '../widgets/custom_new_invoice_screen_button.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/bottom_sheet.dart';
import '../../core/utils/extensions/due_date_calculator.dart';
import '../../core/constants/global_key.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';

class NewInvoiceScreen extends StatefulWidget {
  const NewInvoiceScreen({super.key});

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  var ctx = navigatorKey.currentContext!;

  String dueDate = "-";

  String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

  String number = '';

  void _updateDueDate(String newDate) {
    setState(() {
      dueDate = newDate;
    });
  }

  List<MapEntry<String, int>> dueDateOptions = [
    const MapEntry(AppStrings.noDueDateText, 0),
    const MapEntry(AppStrings.onReceiptDueDateText, 0),
    const MapEntry(AppStrings.tenDaysDueDateText, 10),
    const MapEntry(AppStrings.fifteenDaysDueDateText, 15),
    const MapEntry(AppStrings.thirtyDaysDueDateText, 30),
    const MapEntry(AppStrings.cancelText, -1) //  used to close the bottom sheet
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarType: AppBarType.create,
        onCancel: () {
          Navigator.pop(context);
          Provider.of<ClientProvider>(context, listen: false)
              .clearSelectedClient();
        },
      ),
      floatingActionButton: CustomFloatingButton(
          padding: EdgeInsets.only(bottom: AppSizes.s20.r),
          text: AppStrings.createInvoice,
          onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _buildMainUI(),
    );
  }

  Widget _buildMainUI() {
    return Center(
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
          Padding(
            padding: const EdgeInsets.all(AppSizes.s16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InvoiceIssuedDueSection(
                  dueDateOntap: () {
                    CustomBottomSheet(
                      type: CustomBottomSheetType.floating,
                      header: const Text(AppStrings.selectDueDateText),
                      mainContent: Column(
                        children:
                            [].addDueDateItems(dueDateOptions, (selectedDate) {
                          if (selectedDate != AppStrings.cancelText) {
                            _updateDueDate(selectedDate);
                          }
                          Navigator.pop(ctx);
                        }),
                      ),
                    ).showCustomBottomSheet();
                  },
                  issuedDate: formattedDate,
                  dueDate: dueDate,
                  id: '001',
                ),
                const SizedBox(height: AppSizes.s20),
                Consumer<ClientProvider>(
                  builder: (context, clientProvider, child) {
                    if (clientProvider.selectedClient != null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.clientText,
                            style: AppTextStyles.helveticaNeueSmall(
                                AppColors.darkGrey, FontWeightStyles.regular),
                          ),
                          SizedBox(
                            height: AppSizes.s10.r,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                clientProvider.selectedClient!.clientName,
                                style: AppTextStyles.helveticaNeue(
                                    AppColors.black,
                                    FontWeightStyles.regular,
                                    AppSizes.s18.r),
                              ),
                              IconButton(
                                  onPressed: () =>
                                      clientProvider.clearSelectedClient(),
                                  icon: const Icon(Icons.close_rounded))
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const CustomNewInvoiceScreenButton(
                        appbarTitle: AppStrings.addClientText,
                        title: AppStrings.addClientText,
                        header: AppStrings.clientText,
                        mainChild: ClientScreen(),
                      );
                    }
                  },
                ),
                const SizedBox(height: AppSizes.s20),
                const CustomNewInvoiceScreenButton(
                  appbarTitle: AppStrings.newitemsText,
                  title: AppStrings.addItemText,
                  header: AppStrings.itemsText,
                  mainChild: ItemScreen(),
                ),
                const SizedBox(height: AppSizes.s20),
                const Summary(amount: 15.00),
              ],
            ),
          )
        ],
      ),
    );
  }
}
