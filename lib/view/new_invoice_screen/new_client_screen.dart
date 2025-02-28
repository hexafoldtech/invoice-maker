import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_maker/core/utils/switch_button.dart';
import 'package:invoice_maker/core/utils/text_form_validator.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/client_text_form_field.dart';
import '../../providers/client_provider.dart';
import '../../providers/form_provider.dart';

class NewClientScreen extends StatefulWidget {
  const NewClientScreen({super.key});

  @override
  State<NewClientScreen> createState() => _NewClientScreenState();
}

class _NewClientScreenState extends State<NewClientScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ClientProvider>(context, listen: false).initListners();
  }

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    final formProvider = Provider.of<FormProvider>(context);
    return Padding(
      padding: EdgeInsets.all(AppSizes.s16.r),
      child: Form(
        key: formProvider.formKey,
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
              controller: clientProvider.nameController,
              title: AppStrings.billToText,
              hintText: '',
              textFormType: TextInputType.name,
            ),
            if (clientProvider.isclientFilled)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.saveToClientsCatalogText,
                    style: AppTextStyles.helveticaNeueItem(
                        AppColors.darkGrey, FontWeight.normal),
                  ),
                  SwitchButton(
                    value: clientProvider.saveToClients,
                    onChanged: (value) {
                      clientProvider.setSaveToClients(value);
                    },
                  ),
                ],
              ),
            const SizedBox(height: AppSizes.s16),
            Text(
              AppStrings.contactsText.toUpperCase(),
              style: AppTextStyles.helveticaNeueItem(
                  AppColors.darkGrey, FontWeight.normal),
            ),
            const SizedBox(height: AppSizes.s10),
            ClientTextFormField(
              controller: clientProvider.phoneController,
              title: AppStrings.phoneText,
              hintText: '',
              textFormType: TextInputType.phone,
              validator: TextFormValidator.validatePhoneNumber,
            ),
            const SizedBox(height: AppSizes.s16),
            ClientTextFormField(
              controller: clientProvider.emailController,
              title: AppStrings.emailText,
              hintText: '',
              textFormType: TextInputType.emailAddress,
              validator: TextFormValidator.validateEmail,
            ),
            const SizedBox(height: AppSizes.s16),
            ClientTextFormField(
              controller: clientProvider.addressController,
              title: AppStrings.addressText,
              hintText: '',
              textFormType: TextInputType.streetAddress,
              validator: TextFormValidator.validate,
            ),
            SizedBox(
              height: AppSizes.s30.r,
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.importFromContactsText,
                    style: AppTextStyles.helveticaNeue(
                        AppColors.green, FontWeightStyles.bold, AppSizes.s20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
