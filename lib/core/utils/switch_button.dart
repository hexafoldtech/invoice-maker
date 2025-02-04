import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';

class SwitchButton extends StatelessWidget {
  final bool isOn;
  const SwitchButton({super.key, required this.isOn});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isOn,
      onChanged: (value) {},
      activeColor: AppColors.white,
      activeTrackColor: AppColors.green,
      inactiveThumbColor: AppColors.grey,
      inactiveTrackColor: AppColors.white,
    );
  }
}
