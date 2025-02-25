import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/bottom_sheet.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/global_key.dart';
import "new_client_screen.dart";

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Durations.medium1,
      () {
        _focusNode.requestFocus();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var ctx = navigatorKey.currentContext!;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(AppSizes.s16.r),
          child: TextField(
            focusNode: _focusNode,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: AppStrings.searchText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.s15),
                ),
                fillColor: AppColors.darkGrey),
          ),
        ),
        const SizedBox(
          height: AppSizes.s14,
        ),
        Padding(
          padding: EdgeInsets.only(left: AppSizes.s16.r, bottom: AppSizes.s7.r),
          child: GestureDetector(
            child: Row(
              children: [
                const Icon(
                  Icons.add,
                  color: AppColors.green,
                  size: AppSizes.s20,
                ),
                const SizedBox(width: AppSizes.s8),
                GestureDetector(
                  onTap: () {
                    CustomBottomSheet(
                            type: CustomBottomSheetType.fixed,
                            header: _buildHeader(ctx),
                            fixedheightFactor: 0.88,
                            mainContent:
                                const Expanded(child: NewClientScreen()))
                        .showCustomBottomSheet();
                  },
                  child: Text(
                    AppStrings.addNewClientText,
                    style: AppTextStyles.helveticaNeueItem(
                        AppColors.green, FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: AppSizes.s6.r),
            child: ListView(
              children: const [
                ListTile(
                  title: Text(AppStrings.developmentText),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(ctx),
          child: Padding(
            padding: EdgeInsets.only(left: AppSizes.s12.r),
            child: Text(
              AppStrings.cancelText,
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.regular, AppSizes.s17.r),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(ctx),
          child: Padding(
            padding: EdgeInsets.only(right: AppSizes.s12.r),
            child: Text(
              AppStrings.doneText,
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.regular, AppSizes.s17.r),
            ),
          ),
        ),
      ],
    );
  }
}
