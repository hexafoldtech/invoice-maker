import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/invoice_provider.dart';
import '../../models/InvoiceModel/invoice_model.dart';
import '../widgets/custom_floating_button.dart';
import '../../core/definitions/route_names.dart';
import '../../core/utils/extensions/date_formatter.dart';
import '../../core/utils/extensions/number_formatter.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/extensions/string_formatter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  final InvoiceModel invoice;

  const InvoiceDetailsScreen({super.key, required this.invoice});

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  String dueIn = '';
  double amount = 0;

  void calculateDiff() {
    final diff = DateTime.now().difference(widget.invoice.dueDate).inDays;
    dueIn = '${diff.abs()}d';
  }

  void calcAmount() {
    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);
    final invoice = invoiceProvider.invoices.firstWhere(
      (inv) => inv.id == widget.invoice.id,
      orElse: () => widget.invoice,
    );

    setState(() {
      amount = invoice.paidAmount != 0
          ? widget.invoice.total - invoice.paidAmount
          : widget.invoice.total;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateDiff();
      calcAmount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.dashboardScreen);
          },
        ),
        actions: [
          Text(
            AppStrings.previewText,
            style: AppTextStyles.helveticaNeue(
                AppColors.black, FontWeightStyles.regular, AppSizes.s16.r),
          ),
          const SizedBox(
            width: AppSizes.s20,
          ),
          const Icon(Icons.more_vert_sharp),
          const SizedBox(
            width: AppSizes.s20,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/invoice.jpeg',
                  scale: 2.5,
                ),
                Icon(
                  Icons.remove_red_eye,
                  size: AppSizes.s50.r,
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppSizes.s20.r,
          ),
          Text(
            widget.invoice.client.clientName,
            style: AppTextStyles.helveticaNeueMedium(
                AppColors.black, FontWeightStyles.medium),
          ),
          Text(
            "${AppStrings.rupeeSymbolText} ${amount.formatWithCommas()}",
            style: AppTextStyles.helveticaNeueLarge(
                AppColors.black, FontWeightStyles.medium),
          ),
          SizedBox(
            height: AppSizes.s15.r,
          ),
          Text(
            "${AppStrings.duePreviewText} $dueIn",
            style: AppTextStyles.helveticaNeueSmall(
                AppColors.grey, FontWeightStyles.regular),
          ),
          SizedBox(
            height: AppSizes.s20.r,
          ),
          Provider.of<InvoiceProvider>(context, listen: true)
                      .invoices
                      .firstWhere((inv) => inv.id == widget.invoice.id)
                      .paidAmount ==
                  0
              ? GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, RouteNames.paymentsScreen,
                      arguments: {'invoice': widget.invoice}),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add),
                      Text(
                        AppStrings.addRecievedPaymentText,
                        style: AppTextStyles.helveticaNeueSmall(
                            AppColors.black, FontWeightStyles.regular),
                      ),
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(AppStrings.recievedPayText,
                        style: AppTextStyles.helveticaNeueSmall(
                            AppColors.black, FontWeightStyles.regular)),
                    Text(
                        "${AppStrings.rupeeSymbolText} ${Provider.of<InvoiceProvider>(context).invoices.firstWhere((inv) => inv.id == widget.invoice.id).paidAmount.formatWithCommas()}",
                        style: AppTextStyles.helveticaNeue(AppColors.black,
                            FontWeightStyles.regular, AppSizes.s11.r)),
                  ],
                ),
          SizedBox(
            height: AppSizes.s30.r,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(AppStrings.hasInvoicePaidText,
                  style: AppTextStyles.helveticaNeueSmall(
                      AppColors.black, FontWeightStyles.regular)),
              Container(
                width: AppSizes.s90.r,
                height: AppSizes.s30.r,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.s10),
                    color: AppColors.lightblueShade),
                child: Center(
                    child: Text(AppStrings.markAsPaidText,
                        style: AppTextStyles.helveticaNeue(AppColors.black,
                            FontWeightStyles.regular, AppSizes.s11.r))),
              )
            ],
          ),
          SizedBox(
            height: AppSizes.s30.r,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Provider.of<InvoiceProvider>(context, listen: true)
                            .invoices
                            .firstWhere((inv) => inv.id == widget.invoice.id)
                            .paidAmount !=
                        0
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.totalCapitalText,
                                style: AppTextStyles.helveticaNeueSmall(
                                    AppColors.black, FontWeightStyles.regular),
                              ),
                              Text(
                                "${AppStrings.rupeeSymbolText} ${widget.invoice.total.formatWithCommas()}",
                                style: AppTextStyles.helveticaNeueSmall(
                                    AppColors.grey, FontWeightStyles.regular),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppSizes.s30.r,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.issuedPreviewText,
                      style: AppTextStyles.helveticaNeueSmall(
                          AppColors.black, FontWeightStyles.regular),
                    ),
                    Text(
                      widget.invoice.issueDate.toFormattedString(),
                      style: AppTextStyles.helveticaNeueSmall(
                          AppColors.grey, FontWeightStyles.regular),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.s30.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppStrings.invoiceCapsPreviewText.formatString()} #',
                      style: AppTextStyles.helveticaNeueSmall(
                          AppColors.black, FontWeightStyles.regular),
                    ),
                    Text(
                      (widget.invoice.id + 1).toString().padLeft(3, '0'),
                      style: AppTextStyles.helveticaNeueSmall(
                          AppColors.grey, FontWeightStyles.regular),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.share),
                        Text(AppStrings.shareText),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.print_outlined),
                        Text(AppStrings.printText),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.edit),
                        Text(AppStrings.editText),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppSizes.s20.r,
          ),
          CustomFloatingButton(
            text: AppStrings.sendInvoiceText,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
