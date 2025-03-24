import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_button.dart';
import '../../core/utils/dialog_boxes.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/extensions/string_formatter.dart';
import '../../core/constants/global_key.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';

enum AppBarType { dashboard, create, preview, payments }

enum DashboardAppBarButtons { invoices, estimates }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarType appBarType;

  // Dashboard mode
  final List<CenterButtonItems>? centerButtons;

  // Create mode
  final VoidCallback? onCancel;
  final VoidCallback? onPreview;
  final VoidCallback? onDone;

  //Preview Mode
  final VoidCallback? onPreviewDone;
  final VoidCallback? onPreviewCustomize;

  //Payments Mode
  final VoidCallback? onPaymentsBack;

  const CustomAppBar({
    super.key,
    required this.appBarType,
    this.centerButtons,
    this.onCancel,
    this.onPreview,
    this.onDone,
    this.onPreviewDone,
    this.onPreviewCustomize,
    this.onPaymentsBack,
  });

  @override
  Widget build(BuildContext context) {
    switch (appBarType) {
      case AppBarType.dashboard:
        return _buildDashboardAppBar();
      case AppBarType.create:
        return _buildCreateAppBar();
      case AppBarType.preview:
        return _buildPreviewAppBar();
      case AppBarType.payments:
        return _buildPaymentsAppBar();
    }
  }

  /// 📌 Dashboard App Bar
  Widget _buildDashboardAppBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          forceMaterialTransparency: true,
          leading: IconButton(
            icon: Icon(Icons.message_outlined, size: AppSizes.s24.r),
            onPressed: () {
              DialogBoxes().showComingSoonDialog(navigatorKey.currentContext!);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings_outlined, size: AppSizes.s24.r),
              onPressed: () {
                DialogBoxes()
                    .showComingSoonDialog(navigatorKey.currentContext!);
              },
            ),
          ],
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              centerButtons?.length ?? 0,
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.s4.r),
                child: TextButton(
                  onPressed: centerButtons?[index].action ?? () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Column(
                    children: [
                      Text(
                        centerButtons?[index].label.name.formatString() ?? "",
                        style: AppTextStyles.helveticaNeue(
                          AppColors.black,
                          FontWeight.w600,
                          AppSizes.s16.r,
                        ),
                      ),
                      SizedBox(height: AppSizes.s3.r),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: AppSizes.s2.r,
                          width: AppSizes.s70.r,
                          color: centerButtons?[index].isTapped ?? false
                              ? AppColors.black
                              : AppColors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          centerTitle: true,
          elevation: 3,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }

  /// 📌 Create App Bar
  Widget _buildCreateAppBar() {
    return AppBar(
      forceMaterialTransparency: true,
      elevation: 0,
      leading: AppButton(
          type: ButtonType.flat,
          textColor: AppColors.black,
          label: AppStrings.cancelText,
          action: onCancel ?? () {}),
      centerTitle: false,
      actions: [
        TextButton(
          onPressed: onPreview ??
              () {
                DialogBoxes()
                    .showComingSoonDialog(navigatorKey.currentContext!);
              },
          child: _appBarText(
              AppStrings.previewText, AppColors.black, FontWeight.normal),
        ),
        TextButton(
          onPressed: onDone ?? () {},
          child: _appBarText(
              AppStrings.doneText, AppColors.black, FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildPreviewAppBar() {
    return AppBar(
      forceMaterialTransparency: true,
      elevation: 0,
      leading: AppButton(
          type: ButtonType.flat,
          label: AppStrings.doneText,
          textColor: AppColors.black,
          action: onPreviewDone ?? () {}),
      centerTitle: true,
      title: Text(
        AppStrings.previewText,
        style: AppTextStyles.helveticaNeue(
            AppColors.black, FontWeightStyles.semiBold, AppSizes.s16.r),
      ),
      actions: [
        TextButton(
          onPressed: onPreviewCustomize ??
              () {
                DialogBoxes()
                    .showComingSoonDialog(navigatorKey.currentContext!);
              },
          child: _appBarText(AppStrings.customizeText, AppColors.black,
              FontWeightStyles.regular),
        ),
      ],
    );
  }

  Widget _buildPaymentsAppBar() {
    return AppBar(
      forceMaterialTransparency: true,
      elevation: 0,
      leadingWidth: AppSizes.s70.r,
      leading: GestureDetector(
        onTap: onPaymentsBack ?? () {},
        child: Row(
          children: [
            Icon(
              Icons.arrow_back,
              size: AppSizes.s22.r,
            ),
            SizedBox(
              width: AppSizes.s5.r,
            ),
            Text(
              AppStrings.backText,
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.regular, AppSizes.s16.r),
            )
          ],
        ),
      ),
      centerTitle: true,
      title: Text(
        AppStrings.paymentsText,
        style: AppTextStyles.helveticaNeue(
            AppColors.black, FontWeightStyles.semiBold, AppSizes.s16.r),
      ),
    );
  }

  /// 📌 Helper method for styled text
  Text _appBarText(String title, Color color, FontWeight fontWeight) {
    return Text(
      title,
      style: AppTextStyles.helveticaNeueSmall(color, fontWeight),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

/// 📌 Dashboard Center Button Model
class CenterButtonItems {
  final DashboardAppBarButtons label;
  final VoidCallback action;
  final bool isTapped;

  const CenterButtonItems({
    required this.label,
    required this.action,
    required this.isTapped,
  });
}
