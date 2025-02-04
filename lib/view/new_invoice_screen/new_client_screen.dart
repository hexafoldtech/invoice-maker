import 'package:flutter/material.dart';
import 'package:invoice_maker/boxes/client_boxes.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/core/utils/client_text_form_field.dart';
import 'package:invoice_maker/models/clients_model.dart';

class NewClientScreen extends StatelessWidget {
  const NewClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController clientNameController = TextEditingController();
    TextEditingController clientPhoneNumberController = TextEditingController();
    TextEditingController clientEmailController = TextEditingController();
    TextEditingController clientAddressController = TextEditingController();

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
        actions: [
          TextButton(
            onPressed: () async {
              final data = ClientsModel(
                  id: 1,
                  clientName: clientNameController.text,
                  clientPhoneNumber: clientPhoneNumberController.text,
                  clientEmail: clientEmailController.text,
                  clientAddress: clientAddressController.text);
              final clientBox = ClientBoxes.getData();
              clientBox.add(data);
              data.save();
              clientAddressController.clear;
              clientNameController.clear;
              clientEmailController.clear;
              clientPhoneNumberController.clear;
              print(clientBox);
            },
            child: Text(
              AppStrings.doneText,
              style: AppTextStyles.helveticaNeueSmall(
                  AppColors.darkGrey, FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.newClientText,
                style: AppTextStyles.helveticaNeueMedium(
                    AppColors.black, FontWeight.bold),
              ),
              const SizedBox(
                height: AppSizes.s18,
              ),
              ClientTextFormField(
                controller: clientNameController,
                title: AppStrings.billToText,
                textFormType: '',
              ),
              const SizedBox(height: AppSizes.s16),
              Text(
                AppStrings.contactsText,
                style: AppTextStyles.helveticaNeueItem(
                    AppColors.darkGrey, FontWeight.normal),
              ),
              const SizedBox(height: AppSizes.s10),
              ClientTextFormField(
                controller: clientPhoneNumberController,
                title: AppStrings.phoneText,
                textFormType: '',
              ),
              const SizedBox(height: AppSizes.s16),
              ClientTextFormField(
                controller: clientEmailController,
                title: AppStrings.emailText,
                textFormType: '',
              ),
              const SizedBox(height: AppSizes.s16),
              ClientTextFormField(
                controller: clientAddressController,
                title: AppStrings.addressText,
                textFormType: '',
              ),
              const Spacer(),
              Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.s8),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.grey.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(AppSizes.s8),
                      color: AppColors.white),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      AppStrings.importFromContactsText,
                      style: AppTextStyles.helveticaNeue(
                          AppColors.green, FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
