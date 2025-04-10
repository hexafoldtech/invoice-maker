import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/global_key.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/new_estimate_utils.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../new_invoice_screen/invoice_summary.dart';
import '../widgets/client_screen.dart';
import '../widgets/item_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_floating_button.dart';
import '../widgets/custom_new_invoice_screen_button.dart';
import 'estimate_issued_date_section.dart';

class NewEstimateScreen extends StatefulWidget {
  const NewEstimateScreen({super.key});

  @override
  State<NewEstimateScreen> createState() => _NewEstimateScreenState();
}

class _NewEstimateScreenState extends State<NewEstimateScreen> {
  var ctx = navigatorKey.currentContext!;
  String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarType: AppBarType.create,
        onCancel: () => NewEstimateUtils().onCancel(context),
        onPreview: () => NewEstimateUtils().onPreview(context),
      ),
      bottomNavigationBar: CustomFloatingButton(
          padding: EdgeInsets.only(
            left: AppSizes.s20.r,
            right: AppSizes.s20.r,
            bottom: AppSizes.s20.r,
          ),
          text: AppStrings.createEstimate,
          onPressed: () {
            NewEstimateUtils().onSaveEstimate(context);
          }),
      body: _buildMainUI(),
    );
  }

  Widget _buildMainUI() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Text(
              AppStrings.newEstimateText,
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
                  EstimateIssuedDueSection(
                    issuedDate: formattedDate,
                    id: "EST1",
                  ),
                  const SizedBox(height: AppSizes.s20),
                  // if (clientProvider.selectedClient != null)
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       AppStrings.clientText,
                  //       style: AppTextStyles.helveticaNeueSmall(
                  //           AppColors.darkGrey, FontWeightStyles.regular),
                  //     ),
                  //     SizedBox(
                  //       height: AppSizes.s10.r,
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           "clientProvider.selectedClient!.clientName",
                  //           style: AppTextStyles.helveticaNeue(AppColors.black,
                  //               FontWeightStyles.regular, AppSizes.s16.r),
                  //         ),
                  //         IconButton(
                  //             onPressed: () {
                  //               // clientProvider.clearSelectedClient(),
                  //             },
                  //             icon: const Icon(Icons.close))
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // if (clientProvider.selectedClient == null)
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
                  // const Summary(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
