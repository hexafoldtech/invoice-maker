import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_fonts_styles.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/core/utils/extensions/string_formatter.dart';

enum DashboardAppBarButtons { invoices, estimates }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<CenterButtonItems>? centerButtons;

  const CustomAppBar({super.key, this.centerButtons});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      AppBar(
          leading: SizedBox(
              height: 40,
              width: 40,
              child: IconButton(
                  icon: Icon(Icons.message_outlined, size: AppSizes.s24.r),
                  onPressed: () {
                    // TODO Handle message icon tap
                  })),
          actions: [
            SizedBox(
                height: 40,
                width: 40,
                child: IconButton(
                    icon: Icon(Icons.settings_outlined, size: AppSizes.s24.r),
                    onPressed: () {
                      // TODO Handle settings icon tap
                    }))
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
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                          child: Column(children: [
                            Text(
                                centerButtons?[index]
                                        .label
                                        .name
                                        .formatString() ??
                                    "",
                                style: AppTextStyles.helveticaNeue(
                                    AppColors.black,
                                    FontWeightStyles.semiBold,
                                    AppSizes.s16.r)),
                            SizedBox(height: AppSizes.s3.r),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    height: AppSizes.s2.r,
                                    width: AppSizes.s70.r,
                                    color:
                                        centerButtons?[index].isTapped ?? false
                                            ? AppColors.black
                                            : AppColors.transparent))
                          ]))))),
          centerTitle: true,
          elevation: 3,
          backgroundColor: Colors.white),
      Divider(
          height: AppSizes.s0, thickness: AppSizes.s1.r, color: AppColors.grey)
    ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(40);
}

class CenterButtonItems {
  final DashboardAppBarButtons label;
  final VoidCallback action;
  final bool isTapped;

  const CenterButtonItems(
      {required this.label, required this.action, required this.isTapped});
}
