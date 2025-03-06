import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:invoice_maker/core/definitions/route_names.dart';
import '../../providers/client_provider.dart';
import '../../providers/item_provider.dart';
import '../../providers/invoice_provider.dart';
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
import '../../core/constants/app_fonts_styles.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        appBarType: AppBarType.create,
        onCancel: () {
          Navigator.pop(context);
          if (Provider.of<ClientProvider>(context, listen: false)
                      .selectedClient !=
                  null ||
              Provider.of<ItemProvider>(context, listen: false)
                  .selectedItems
                  .isNotEmpty) {
            Provider.of<ClientProvider>(context, listen: false)
                .clearSelectedClient();
            Provider.of<ItemProvider>(context, listen: false)
                .clearSelectedItems();
          }
        },
        onPreview: () => Navigator.pushNamed(context, RouteNames.previewScreen),
      ),
      bottomNavigationBar: CustomFloatingButton(
          padding: EdgeInsets.only(
            left: AppSizes.s20.r,
            right: AppSizes.s20.r,
            bottom: AppSizes.s20.r,
          ),
          text: AppStrings.createInvoice,
          onPressed: () {
            _onSaveInvoice();
          }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _buildMainUI(),
    );
  }

  Widget _buildMainUI() {
    return SingleChildScrollView(
      child: Consumer2<ClientProvider, InvoiceProvider>(
          builder: (context, clientProvider, invoiceProvider, child) {
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
                            children: [].addDueDateItems(
                                invoiceProvider.dueDateOptions, (selectedDate) {
                              if (selectedDate != AppStrings.cancelText) {
                                invoiceProvider.updateDueDate(selectedDate);
                              }
                              Navigator.pop(ctx);
                            }),
                          ),
                        ).showCustomBottomSheet();
                      },
                      issuedDate: formattedDate,
                      dueDate: invoiceProvider.dueDate,
                      id: invoiceProvider.generateInvoiceId(),
                    ),
                    const SizedBox(height: AppSizes.s20),
                    if (clientProvider.selectedClient != null)
                      Column(
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
                                    AppSizes.s16.r),
                              ),
                              IconButton(
                                  onPressed: () =>
                                      clientProvider.clearSelectedClient(),
                                  icon: const Icon(Icons.close))
                            ],
                          ),
                        ],
                      ),
                    if (clientProvider.selectedClient == null)
                      const CustomNewInvoiceScreenButton(
                        appbarTitle: AppStrings.addClientText,
                        title: AppStrings.addClientText,
                        header: AppStrings.clientText,
                        mainChild: ClientScreen(),
                      ),
                    const SizedBox(height: AppSizes.s20),
                    const CustomNewInvoiceScreenButton(
                      appbarTitle: AppStrings.newitemsText,
                      title: AppStrings.addItemText,
                      header: AppStrings.itemsText,
                      mainChild: ItemScreen(),
                    ),
                    const SizedBox(height: AppSizes.s20),
                    const Summary(),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  void _onSaveInvoice() {
    if (Provider.of<ClientProvider>(context, listen: false).selectedClient !=
            null &&
        Provider.of<ItemProvider>(context, listen: false)
            .selectedItems
            .isNotEmpty) {
      var invoiceProvider =
          Provider.of<InvoiceProvider>(context, listen: false);
      var newInvoice = invoiceProvider.createInvoiceModel();
      invoiceProvider.addInvoice(newInvoice).then((_) {
        if (ctx.mounted) {
          Provider.of<ItemProvider>(ctx, listen: false).clearSelectedItems();
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
