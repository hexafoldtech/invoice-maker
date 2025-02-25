import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/view/new_invoice_screen/new_client_screen.dart';

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
    return Scaffold(
      body: Column(
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
            padding:
                EdgeInsets.only(left: AppSizes.s16.r, bottom: AppSizes.s7.r),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewClientScreen(),
                        ),
                      );
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
      ),
    );
  }
}
