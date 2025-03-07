import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_fonts_styles.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_button.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/view/widgets/custom_app_bar.dart';

import '../../core/utils/custom_text_form_field.dart';
import '../../core/utils/switch_button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isEditing = false;
  String _receivedAmount = "";
  bool _isSwitch = false;

  final TextEditingController _controller = TextEditingController();

  void _savePayment() {
    setState(() {
      _receivedAmount = _controller.text;
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarType: AppBarType.payments,
        onPaymentsBack: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                AppStrings.paidFullText,
                style: AppTextStyles.helveticaNeue(
                    AppColors.black, FontWeightStyles.regular, AppSizes.s20),
              ),
              SwitchButton(
                value: _isSwitch,
                onChanged: (value) {
                  setState(() {
                    _isSwitch = value;
                  });
                },
              )
            ],
          ),
          const SizedBox(
            height: AppSizes.s20,
          ),
          if (_isEditing)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: AppSizes.s100,
                  child: CustomTextFormField(
                    formType: FormType.item,
                    textInputType: TextInputType.number,
                    controller: _controller,
                    hintText: '0%',
                  ),
                ),
                AppButton(
                  type: ButtonType.flat,
                  label: AppStrings.saveText,
                  textColor: AppColors.green,
                  action: () {
                    _savePayment();
                  },
                ),
              ],
            ),
          if (_receivedAmount.isNotEmpty)
            Text(
              "Received Payment: ${AppStrings.rupeeSymbolText} $_receivedAmount",
              style: AppTextStyles.helveticaNeue(
                  AppColors.black, FontWeightStyles.bold, AppSizes.s18),
            ),
          AppButton(
            type: ButtonType.flat,
            label: AppStrings.addPartialPaymentText,
            textColor: AppColors.green,
            action: () {
              setState(() {
                _isEditing = true;
              });
            },
          ),
        ],
      ),
    );
  }
}
