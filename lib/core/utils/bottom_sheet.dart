import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_sizes.dart';
import '../constants/global_key.dart';

class CustomBottomSheet {
  final ctx = navigatorKey.currentContext;
  // bottom sheet for creating new item and clients
  void showCustomHeightBottomSheet(double heightFactor) {
    if (ctx != null && ctx!.mounted) {
      showModalBottomSheet(
        context: ctx!,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) => FractionallySizedBox(
          heightFactor: heightFactor,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: AppSizes.s45.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(ctx!),
                      child: Padding(
                        padding: EdgeInsets.only(left: AppSizes.s14.r),
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: AppSizes.s15.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'This bottom sheet is 75% of screen height!',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
