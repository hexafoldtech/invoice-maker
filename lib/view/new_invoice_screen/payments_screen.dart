import 'package:flutter/material.dart';
import 'package:invoice_maker/providers/invoice_provider.dart';
import 'package:provider/provider.dart';
import '../../models/InvoiceModel/invoice_model.dart';
import '../widgets/custom_app_bar.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/app_button.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/custom_text_form_field.dart';
import '../../core/utils/switch_button.dart';

class PaymentScreen extends StatefulWidget {
  final InvoiceModel invoice;
  const PaymentScreen({super.key, required this.invoice});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isEditing = false;
  String _receivedAmount = "";
  bool _isSwitch = false;
  final FocusNode _focusNode = FocusNode();

  final TextEditingController _controller = TextEditingController();

  void _savePayment() {
    setState(() {
      _receivedAmount = _controller.text;
      _isEditing = false;
    });
    if (double.parse(_receivedAmount) < widget.invoice.total) {
      Provider.of<InvoiceProvider>(context, listen: false)
          .updateInvoiceAmount(widget.invoice, double.parse(_receivedAmount));
    }
    _focusNode.unfocus();
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
                    focusNode: _focusNode,
                    formType: FormType.item,
                    textInputType: TextInputType.number,
                    controller: _controller,
                    hintText: '${AppStrings.rupeeSymbolText}0',
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
              _focusNode.requestFocus();
            },
          ),
        ],
      ),
    );
  }
}
