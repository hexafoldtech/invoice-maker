import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/client_provider.dart';
import '../../models/ClientModel/clients_model.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/client_text_form_field.dart';

class NewClientScreen extends StatelessWidget {
  const NewClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
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
              clientProvider.addClient(data);
              clientAddressController.clear;
              clientNameController.clear;
              clientEmailController.clear;
              clientPhoneNumberController.clear;
              // print(clientBox);
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
                          AppColors.green, FontWeightStyles.bold, AppSizes.s12),
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
