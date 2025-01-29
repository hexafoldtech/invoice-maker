import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/view/new_invoice_screen/new_client_screen.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppStrings.cancelText,
            style: AppTextStyles.helveticaNeueSmall(
                AppColors.black, FontWeight.normal),
          ),
        ),
        centerTitle: true,
        title: Text(
          AppStrings.clientsText,
          style: AppTextStyles.helveticaNeueMedium(
              AppColors.black, FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16),
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
            child: ListView(
              children: const [
                ListTile(
                  title: Text(AppStrings.developmentText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
