import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:invoice_maker/models/EstimateModel/estimate_model.dart';
import 'package:invoice_maker/providers/client_provider.dart';
import 'package:invoice_maker/providers/item_provider.dart';
import 'package:invoice_maker/repository/estimate_repo.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_strings.dart';
import '../core/constants/hive_box_names.dart';

enum AppUIStates { loading, empty, success, none }

class EstimateProvider extends ChangeNotifier {
  final EstimateRepo _estimateRepo = EstimateRepo();
  final BuildContext context;
  EstimateProvider({required this.context});

  List<EstimateModel> _estimates = [];
  AppUIStates _state = AppUIStates.none;
  bool _isLoading = false;

  final TextEditingController _taxController = TextEditingController();
  bool _showTaxTypeRow = false;
  String _selectedTaxType = AppStrings.inclusiveText;
  String _taxText = AppStrings.taxText;

  List<EstimateModel> get estimates => _estimates;
  AppUIStates get state => _state;
  bool get isLoading => _isLoading;
  TextEditingController get taxController => _taxController;
  bool get showTaxTypeRow => _showTaxTypeRow;
  String get selectedTaxType => _selectedTaxType;
  String get taxText => _taxText;

  double get subTotal => Provider.of<ItemProvider>(context, listen: false)
      .selectedItems
      .fold(0, (sum, item) => sum + (item.itemUnitPrice * item.itemQuantity));

  double _calculateTotalDiscount() {
    return Provider.of<ItemProvider>(context, listen: false)
        .selectedItems
        .fold(0, (sum, item) {
      if (item.isDiscount && item.itemDiscount != null) {
        return sum + item.itemDiscount!;
      }
      return sum;
    });
  }

  double get totalDiscount => _calculateTotalDiscount();

  double _calculateTotalTax() {
    String taxText =
        taxController.text.replaceAll('%', ''); // Remove '%' if present
    double taxRate = double.tryParse(taxText) ?? 0.0; // Convert to double

    // Calculate subtotal only for taxable items
    double taxableSubTotal = Provider.of<ItemProvider>(context, listen: false)
        .selectedItems
        .where((item) => item.itemTaxable)
        .fold(0, (sum, item) => sum + (item.itemUnitPrice * item.itemQuantity));
    log(taxableSubTotal.toString());
    // Subtract total discount from taxable subtotal
    double taxableSubTotalAfterDiscount = taxableSubTotal - totalDiscount;
    log(taxableSubTotalAfterDiscount.toString());
    if (selectedTaxType == AppStrings.exclusiveText) {
      // Tax is added on top of the price, only for taxable items
      return taxableSubTotalAfterDiscount * (taxRate / 100);
    } else if (selectedTaxType == AppStrings.inclusiveText) {
      // Tax is already included in the price, reverse calculate for taxable items
      return taxableSubTotalAfterDiscount -
          (taxableSubTotalAfterDiscount / (1 + (taxRate / 100)));
    }

    return 0.0;
  }

  double get tax => _calculateTotalTax();

  double get totalAmount {
    double priceAfterDiscount = subTotal - totalDiscount;
    return _selectedTaxType == AppStrings.exclusiveText
        ? (priceAfterDiscount + tax)
        : priceAfterDiscount;
  }

  void _updateFormattedTaxText() {
    if (taxController.text.isNotEmpty) {
      _taxText =
          "${AppStrings.taxText} (${taxController.text} $_selectedTaxType)";
    } else {
      _taxText = AppStrings.taxText;
    }
    notifyListeners(); // Ensure UI updates
  }

  void _handleTaxInputChange() {
    bool shouldShow = taxController.text.isNotEmpty;
    if (_showTaxTypeRow != shouldShow) {
      _showTaxTypeRow = shouldShow;
      notifyListeners();
    }
  }

  /// Update the selected discount type
  void updateTaxType(String newTaxType) {
    _selectedTaxType = newTaxType;
    notifyListeners();
  }

  String generateEstimateId() {
    final box = Hive.box<EstimateModel>(HiveBoxNames.estimates);
    int nextId = box.length + 1;
    return "EST$nextId";
  }

  EstimateModel createEstimateModel() {
    final box = Hive.box<EstimateModel>(HiveBoxNames.estimates);
    final int newId = (box.isEmpty)
        ? 0
        : box.keys
                .cast<int>()
                .reduce((value, element) => value > element ? value : element) +
            1;

    return EstimateModel(
        id: newId,
        client:
            Provider.of<ClientProvider>(context, listen: false).selectedClient!,
        issueDate: DateTime.now(),
        items: Provider.of<ItemProvider>(context, listen: false).selectedItems,
        discount: totalDiscount,
        subTotal: subTotal,
        total: totalAmount,
        taxType: _selectedTaxType,
        tax: tax);
  }

  void initListners() {
    _taxController.addListener(_handleTaxInputChange);
    _taxController.addListener(_updateFormattedTaxText);
  }

  Future<void> fetchEstimates() async {
    _isLoading = true;
    notifyListeners();

    try {
      _estimates = await _estimateRepo.getAllEstimates();
    } catch (e) {
      _state = AppUIStates.empty;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addEstimate(EstimateModel estimate) async {
    try {
      await _estimateRepo.saveEstimate(estimate);
      _estimates.add(estimate);
      notifyListeners();
    } catch (e) {
      _state = AppUIStates.empty;
      notifyListeners();
    }
  }

  Future<void> updateEstimate(EstimateModel estimate) async {
    try {
      await _estimateRepo.updateEstimate(estimate);
      int index = _estimates.indexWhere((i) => i.id == estimate.id);
      if (index != -1) {
        _estimates[index] = estimate;
        notifyListeners();
      }
    } catch (e) {
      _state = AppUIStates.empty;
      notifyListeners();
    }
  }

  Future<void> deleteEstimate(int id) async {
    try {
      await _estimateRepo.deleteEstimate(id);
      _estimates.removeWhere((invoice) => invoice.id == id);
      notifyListeners();
    } catch (e) {
      _state = AppUIStates.empty;
      notifyListeners();
    }
  }
}
