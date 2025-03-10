import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/utils/total_invoice_amount.dart';
import '../../../core/utils/year_picker.dart';
import '../../../providers/reports_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';

class ReportsScreens extends StatefulWidget {
  const ReportsScreens({super.key});

  @override
  State<ReportsScreens> createState() => _ReportsScreensState();
}

class _ReportsScreensState extends State<ReportsScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReportsProvider>(context, listen: false).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportsProvider>(
      builder: (context, reportsProvider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.s16.r),
          child: SizedBox(
            height: ScreenUtil.defaultSize.height / 1.13,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.incomeText,
                    style: AppTextStyles.helveticaNeue(
                        AppColors.black, FontWeight.bold, AppSizes.s18.r),
                  ),
                  const SizedBox(height: AppSizes.s12),

                  const Center(child: YearPickerButton()),
                  const SizedBox(height: AppSizes.s16),

                  /// **Total Invoice**
                  TotalInvoiceAmount(
                      amount: reportsProvider.total,
                      title: AppStrings.totalCapitalText),

                  /// **Quarterly Sections**
                  ...reportsProvider.quarterlyData
                      .map((qData) => buildQuarterSection(
                            qData['quarter'],
                            qData['total'],
                            qData['months'],
                          )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
