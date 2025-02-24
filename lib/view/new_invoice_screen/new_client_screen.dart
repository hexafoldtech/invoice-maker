import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../providers/client_provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/client_text_form_field.dart';

class NewClientScreen extends StatefulWidget {
  const NewClientScreen({super.key});

  @override
  State<NewClientScreen> createState() => _NewClientScreenState();
}

class _NewClientScreenState extends State<NewClientScreen> {
  // final clientProvider = Provider.of<ClientProvider>(context);
  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientPhoneNumberController = TextEditingController();
  TextEditingController clientEmailController = TextEditingController();
  TextEditingController clientAddressController = TextEditingController();
  bool isclientFilled = false;
  bool saveToClients = false;

  /// Toggles switch visibility based on client name input
  void _toggleSwitchVisibility() {
    setState(() {
      isclientFilled = clientNameController.text.isNotEmpty;
      saveToClients = clientNameController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Durations.medium4,
        () => clientNameController.addListener(_toggleSwitchVisibility));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              hintText: '',
              textFormType: TextInputType.datetime,
            ),
            if (isclientFilled)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.saveToClientsCatalogText,
                    style: AppTextStyles.helveticaNeueItem(
                        AppColors.darkGrey, FontWeight.normal),
                  ),
                  Switch(
                    value: saveToClients,
                    onChanged: (value) {
                      setState(() {
                        saveToClients = value;
                      });
                    },
                    activeColor: AppColors.green,
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
              controller: clientPhoneNumberController,
              title: AppStrings.phoneText,
              hintText: '',
              textFormType: TextInputType.datetime,
            ),
            const SizedBox(height: AppSizes.s16),
            ClientTextFormField(
              controller: clientEmailController,
              title: AppStrings.emailText,
              hintText: '',
              textFormType: TextInputType.datetime,
            ),
            const SizedBox(height: AppSizes.s16),
            ClientTextFormField(
              controller: clientAddressController,
              title: AppStrings.addressText,
              hintText: '',
              textFormType: TextInputType.datetime,
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
