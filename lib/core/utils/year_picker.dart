import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/utils/app_button.dart';

class YearPickerButton extends StatefulWidget {
  const YearPickerButton({super.key});
  @override
  _YearPickerButtonState createState() => _YearPickerButtonState();
}

class _YearPickerButtonState extends State<YearPickerButton> {
  int _selectedYear = DateTime.now().year;

  void _showYearPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$_selectedYear"),
          content: SizedBox(
            width: double.maxFinite,
            height: AppSizes.s200,
            child: YearPicker(
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              initialDate: DateTime(_selectedYear),
              selectedDate: DateTime(_selectedYear),
              onChanged: (DateTime selectedDate) {
                setState(() {
                  _selectedYear = selectedDate.year;
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppButton(
            type: ButtonType.selectTimer,
            label: "$_selectedYear",
            action: () => _showYearPicker(context),
          )
        ],
      ),
    );
  }
}
