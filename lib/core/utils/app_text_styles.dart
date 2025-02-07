import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';

class AppTextStyles {
  //textStyle for helveticaNeue
  static TextStyle helveticaNeue(Color color, FontWeight fontWeight, double fontSize) {
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.5,
      color: color,
    );
  }

  //textStyle for helveticaNeueLarge
  static TextStyle helveticaNeueLarge(Color color, FontWeight fontWeight) {
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: AppSizes.s49,
      fontWeight: fontWeight,
      height: 1.5,
      color: color,
    );
  }

  static TextStyle helveticaNeueItem(Color color, FontWeight fontWeight) {
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: AppSizes.s18,
      fontWeight: fontWeight,
      height: 1.5,
      color: color,
    );
  }

  static TextStyle helveticaNeueMedium(Color color, FontWeight fontWeight) {
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: AppSizes.s29,
      fontWeight: fontWeight,
      height: 1.5,
      color: color,
    );
  }

  static TextStyle helveticaNeueSmall(Color color, FontWeight fontWeight) {
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: AppSizes.s15,
      fontWeight: fontWeight,
      height: 1.5,
      color: color,
    );
  }
}
