import 'package:flutter/material.dart';

/// a [form Provider] for handling cross UI validation & submit operations
class FormProvider extends ChangeNotifier {
  final GlobalKey<FormState> _clientFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _itemFormKey = GlobalKey<FormState>();

  get clientformKey => _clientFormKey;
  get itemformKey => _itemFormKey;

  bool validateClientForm() {
    if (_clientFormKey.currentState?.validate() ?? false) {
      _clientFormKey.currentState?.save();
      return true;
    }
    return false;
  }

  bool validateItemForm() {
    if (_itemFormKey.currentState?.validate() ?? false) {
      _itemFormKey.currentState?.save();
      return true;
    }
    return false;
  }
}
