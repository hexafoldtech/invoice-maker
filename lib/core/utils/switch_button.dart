import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';

class SwitchButton extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  const SwitchButton({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.white,
      activeTrackColor: AppColors.green,
      inactiveThumbColor: AppColors.grey,
      inactiveTrackColor: AppColors.white,
    );
  }
}
