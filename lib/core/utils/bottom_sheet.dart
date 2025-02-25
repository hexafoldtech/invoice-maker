import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_sizes.dart';
import '../constants/global_key.dart';

enum CustomBottomSheetType { fixed, floating }

/// Custom [bottom sheet] for creating new item and clients and selecting date
class CustomBottomSheet {
  final ctx = navigatorKey.currentContext!;
  final bool isScrollControlled;
  final Color backgroundColor;
  final CustomBottomSheetType type;
  final Widget header;
  final Widget mainContent;
  final double fixedheightFactor;
  final double fixedwidthFactor;
  final double floatingHeight;

  CustomBottomSheet({
    required this.type,
    required this.header,
    required this.mainContent,
    this.isScrollControlled = true,
    this.backgroundColor = Colors.transparent,
    this.fixedheightFactor = 0.4,
    this.fixedwidthFactor = 1.0,
    double? floatingHeight,
  }) : floatingHeight = floatingHeight ?? AppSizes.s330.r;

  void showCustomBottomSheet() {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      builder: (context) => _buildBottomSheet(),
    );
  }

  Widget _buildBottomSheet() {
    switch (type) {
      case CustomBottomSheetType.fixed:
        return _fixedTypeWidget();
      case CustomBottomSheetType.floating:
        return _floatingTypeWidget();
    }
  }

  /// widget for [fixed bottom sheet]
  Widget _fixedTypeWidget() {
    return FractionallySizedBox(
      heightFactor: fixedheightFactor,
      widthFactor: fixedwidthFactor,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.s20),
              topRight: Radius.circular(AppSizes.s20)),
        ),
        height: AppSizes.s400.r,
        child: Column(
          children: [
            _buildHeader(),
            mainContent,
          ],
        ),
      ),
    );
  }

  /// widget for [floating bottom sheet]
  Widget _floatingTypeWidget() {
    return Container(
      height: floatingHeight,
      margin: const EdgeInsets.all(20),
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(),
          mainContent,
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(top: AppSizes.s10.r),
      child: header,
    );
  }
}
