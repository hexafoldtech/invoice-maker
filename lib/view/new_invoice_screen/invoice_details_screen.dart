import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_floating_button.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/extensions/string_formatter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  final String clientName;
  final double amount;
  final String issueDate;
  final DateTime dueDate;
  final bool? paid;
  final String invoiceNo;

  const InvoiceDetailsScreen(
      {super.key,
      required this.clientName,
      required this.amount,
      required this.issueDate,
      required this.dueDate,
      this.paid,
      required this.invoiceNo});

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  String dueIn = '';

  void calculateDiff() {
    final diff = DateTime.now().difference(widget.dueDate).inDays;
    dueIn = '${diff.abs()}d';
  }

  @override
  void initState() {
    super.initState();
    calculateDiff();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
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
            widget.clientName,
            style: AppTextStyles.helveticaNeueMedium(
                AppColors.black, FontWeightStyles.medium),
          ),
          Text(
            "${AppStrings.rupeeSymbolText} ${widget.amount}",
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
          Row(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.issuedPreviewText,
                      style: AppTextStyles.helveticaNeueSmall(
                          AppColors.black, FontWeightStyles.regular),
                    ),
                    Text(
                      widget.issueDate,
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
                      widget.invoiceNo,
                      style: AppTextStyles.helveticaNeueSmall(
                          AppColors.grey, FontWeightStyles.regular),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
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
