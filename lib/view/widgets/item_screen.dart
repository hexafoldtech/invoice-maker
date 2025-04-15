import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/utils/extensions/number_formatter.dart';
import 'package:invoice_maker/providers/item_provider.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/global_key.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/bottom_sheet.dart';
import 'new_item_screen.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  void initState() {
    super.initState();

    /// Call inital fetch items after page building to populate the list
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<ItemProvider>(context, listen: false).fetchAllItems();
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
                            mainContent: const Expanded(child: NewItemScreen()))
                        .showCustomBottomSheet();
                  },
                  child: Text(
                    AppStrings.addNewItemText,
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
              child: Consumer<ItemProvider>(
                builder: (context, provider, child) {
                  switch (provider.state) {
                    case AppUIStates.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case AppUIStates.empty:
                      return Center(
                        child: Text(
                          AppStrings.noItemsText,
                          style: AppTextStyles.helveticaNeue(
                              AppColors.grey, FontWeight.w500, AppSizes.s16.r),
                        ),
                      );
                    case AppUIStates.success:
                      return ListView.builder(
                        itemCount: provider.items.length,
                        itemBuilder: (context, index) {
                          final items = provider.items[index];
                          var unit = '';
                          if (items.unitType != null) {
                            unit = "/ ${items.unitType!}";
                          }
                          return ListTile(
                            title: Text(
                              items.itemName,
                              style: AppTextStyles.helveticaNeue(
                                  AppColors.black,
                                  FontWeight.w500,
                                  AppSizes.s16.r),
                            ),
                            onTap: () {
                              provider.selectItems(items);
                              Navigator.pop(ctx);
                            },
                            trailing: Text(
                              "${items.itemPrice.formatWithCommas()} $unit",
                              style: AppTextStyles.helveticaNeue(
                                  AppColors.darkGrey,
                                  FontWeight.w500,
                                  AppSizes.s12.r),
                            ),
                          );
                        },
                      );

                    case AppUIStates.none:
                      return const SizedBox.shrink();
                  }
                },
              )),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<ItemProvider>(navigatorKey.currentContext!,
                    listen: false)
                .clearForm();
            Navigator.pop(ctx);
          },
          child: Padding(
            padding: EdgeInsets.only(left: AppSizes.s12.r),
            child: Text(
              AppStrings.cancelText,
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.regular, AppSizes.s17.r),
            ),
          ),
        ),
      ],
    );
  }
}
