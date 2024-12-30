import 'dart:ui';

import 'package:invoice_maker/core/constants/app_sizes.dart';

class AppTextStyles {
  //textStyle for poppinsBody
  static TextStyle poppinsBody(Color color, FontWeight fontWeight) {
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: AppSizes.s16,
      fontWeight: fontWeight,
      height: 1.5,
      color: color,
    );
  }
}
