import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/core/utils/extensions/date_formatter.dart';
import 'package:invoice_maker/providers/estimate_provider.dart';
import 'package:invoice_maker/view/dashboard_screen/estimates_view/estimates_item.dart';
import 'package:invoice_maker/view/dashboard_screen/estimates_view/total_recieved_amount.dart';
import 'package:provider/provider.dart';

import '../../../core/definitions/route_names.dart';

class EstimatesScreen extends StatefulWidget {
  const EstimatesScreen({super.key});

  @override
  State<EstimatesScreen> createState() => _EstimatesScreenState();
}

class _EstimatesScreenState extends State<EstimatesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<EstimateProvider>(context, listen: false).fetchEstimates();
        print(
            " est:::${Provider.of<EstimateProvider>(context, listen: false).estimates}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EstimateProvider>(
      builder: (context, estimateProvider, child) {
        return estimateProvider.estimates.isNotEmpty
            ? Center(
                child: Column(
                children: [
                  SizedBox(height: AppSizes.s15.r),
                  Text(AppStrings.estimatesTabText,
                      style: AppTextStyles.helveticaNeue(
                          AppColors.black, FontWeight.bold, AppSizes.s30.r)),
                  SizedBox(height: AppSizes.s11.r),
                  TotalReceivedAmount(
                      title: AppStrings.total,
                      amount: estimateProvider.estimates
                          .fold(0.0, (sum, e) => sum + e.total)),
                  SizedBox(height: AppSizes.s5.r),
                  SizedBox(
                    height: AppSizes.s400.r,
                    child: ListView.builder(
                      itemCount: estimateProvider.estimates.length,
                      itemBuilder: (context, index) {
                        return EstimatesItem(
                          client: estimateProvider
                              .estimates[index].client.clientName,
                          id: estimateProvider.estimates[index].id,
                          dueDate: estimateProvider.estimates[index].issueDate
                              .toFormattedString(),
                          amount: estimateProvider.estimates[index].total,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.estimateDetailsScreen,
                              arguments: {
                                'estimate': estimateProvider.estimates[index]
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSizes.s15)
                ],
              ))
            : Center(
                child: Text(
                  AppStrings.noEstimatesText,
                  style: AppTextStyles.helveticaNeue(
                      AppColors.black, FontWeight.normal, AppSizes.s15.r),
                ),
              );
      },
    );
  }
}
