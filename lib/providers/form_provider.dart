import 'package:flutter/material.dart';

/// a [form Provider] for handling cross UI validation & submit operations
class FormProvider extends ChangeNotifier {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  get formKey => _formKey;

  bool validateForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      return true;
    }
    return false;
  }
}
