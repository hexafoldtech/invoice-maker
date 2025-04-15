import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:invoice_maker/core/constants/global_key.dart';
import 'package:invoice_maker/core/utils/extensions/due_date_calculator.dart';
import 'package:invoice_maker/core/utils/extensions/string_formatter.dart';
import 'package:invoice_maker/providers/estimate_provider.dart';
import 'package:invoice_maker/providers/invoice_provider.dart';
import 'package:provider/provider.dart';
import '../../core/utils/bottom_sheet.dart';
import '../../models/EstimateModel/estimate_model.dart';
import '../../core/definitions/route_names.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/extensions/date_formatter.dart';
import '../../core/utils/extensions/number_formatter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../widgets/custom_floating_button.dart';
import 'preview_screen.dart';

class EstimateDetailsScreen extends StatefulWidget {
  final EstimateModel estimate;
  const EstimateDetailsScreen({super.key, required this.estimate});

  @override
  State<EstimateDetailsScreen> createState() => _EstimateDetailsScreenState();
}

class _EstimateDetailsScreenState extends State<EstimateDetailsScreen> {
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
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.estimatePreviewScreen,
                  arguments: {
                    'type': PreviewType.details,
                    'estimate': widget.estimate
                  });
            },
            child: Text(
              AppStrings.previewText,
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.regular, AppSizes.s16.r),
            ),
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
            widget.estimate.client.clientName,
            style: AppTextStyles.helveticaNeueMedium(
                AppColors.black, FontWeightStyles.medium),
          ),
          Text(
            "${AppStrings.rupeeSymbolText} ${widget.estimate.total.formatWithCommas()}",
            style: AppTextStyles.helveticaNeueLarge(
                AppColors.black, FontWeightStyles.medium),
          ),
          SizedBox(
            height: AppSizes.s15.r,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.s50.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.issuedPreviewText,
                  style: AppTextStyles.helveticaNeueSmall(
                      AppColors.black, FontWeightStyles.regular),
                ),
                Text(
                  widget.estimate.issueDate.toFormattedString(),
                  style: AppTextStyles.helveticaNeueSmall(
                      AppColors.grey, FontWeightStyles.regular),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSizes.s30.r),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.s50.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppStrings.estimateText} #',
                  style: AppTextStyles.helveticaNeueSmall(
                      AppColors.black, FontWeightStyles.regular),
                ),
                Text(
                  "EST${widget.estimate.id + 1}",
                  style: AppTextStyles.helveticaNeueSmall(
                      AppColors.grey, FontWeightStyles.regular),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: AppSizes.s150.r,
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.email),
                    Text(AppStrings.emailText),
                  ],
                ),
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
            SizedBox(
              height: AppSizes.s20.r,
            ),
            CustomFloatingButton(
              icon: Icons.transform_sharp,
              text: AppStrings.convertToInvoiceText,
              onPressed: () {
                CustomBottomSheet(
                  type: CustomBottomSheetType.floating,
                  header: const Text(AppStrings.selectDueDateText),
                  mainContent: Column(
                    children: [].addDueDateItems(
                        Provider.of<InvoiceProvider>(context, listen: false)
                            .dueDateOptions, (selectedDate) {
                      if (selectedDate != AppStrings.cancelText) {
                        var invoice = Provider.of<EstimateProvider>(context,
                                listen: false)
                            .createInvoiceModel(widget.estimate,
                                dueDate: selectedDate.toDateTime());
                        Provider.of<EstimateProvider>(context, listen: false)
                            .deleteEstimate(widget.estimate.id);
                        Provider.of<InvoiceProvider>(context, listen: false)
                            .addInvoice(invoice);
                        Navigator.pop(navigatorKey.currentContext!);
                        Navigator.pushNamed(
                            context, RouteNames.dashboardScreen);
                      }
                    }),
                  ),
                ).showCustomBottomSheet();
              },
            ),
          ],
        ),
      ),
    );
  }
}
