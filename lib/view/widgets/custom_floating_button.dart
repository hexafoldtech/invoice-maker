import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class CustomFloatingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;
  const CustomFloatingButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.icon,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Material(
        elevation: AppSizes.s5,
        borderRadius: BorderRadius.circular(AppSizes.s10),
        color: AppColors.darkBlueShade,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: AppSizes.s350.r,
            height: AppSizes.s50.r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null
                    ? Icon(
                        icon,
                        color: AppColors.white,
                      )
                    : const SizedBox(),
                Text(
                  text,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppSizes.s16.r,
                      fontWeight: FontWeightStyles.medium),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
