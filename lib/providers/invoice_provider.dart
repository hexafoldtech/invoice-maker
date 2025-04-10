import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../repository/invoice_repo.dart';
import 'client_provider.dart';
import 'item_provider.dart';
import '../../../models/InvoiceModel/invoice_model.dart';
import '../core/utils/extensions/string_formatter.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/hive_box_names.dart';

enum AppUIStates { loading, empty, success, none }

class InvoiceProvider extends ChangeNotifier {
  final InvoiceRepo _invoiceRepo = InvoiceRepo();
  final BuildContext context;
  InvoiceProvider({required this.context});

  List<InvoiceModel> _invoices = [];
  AppUIStates _state = AppUIStates.none;
  bool _isLoading = false;
  String _dueDate = "-";
  final List<MapEntry<String, int>> _dueDateOptions = [
    const MapEntry(AppStrings.noDueDateText, 0),
    const MapEntry(AppStrings.onReceiptDueDateText, 0),
    const MapEntry(AppStrings.tenDaysDueDateText, 10),
    const MapEntry(AppStrings.fifteenDaysDueDateText, 15),
    const MapEntry(AppStrings.thirtyDaysDueDateText, 30),
    const MapEntry(AppStrings.cancelText, -1) //  used to close the bottom sheet
  ];
  final TextEditingController _taxController = TextEditingController();
  bool _showTaxTypeRow = false;
  String _selectedTaxType = AppStrings.inclusiveText;
  String _taxText = AppStrings.taxText;

  List<InvoiceModel> get invoices => _invoices;
  AppUIStates get state => _state;
  bool get isLoading => _isLoading;
  String get dueDate => _dueDate;
  List<MapEntry<String, int>> get dueDateOptions => _dueDateOptions;
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

  void updateDueDate(String newDueDate) {
    _dueDate = newDueDate;
    notifyListeners();
  }

  String generateInvoiceId() {
    final box = Hive.box<InvoiceModel>(HiveBoxNames.invoices);
    int nextId = box.length + 1;
    return nextId.toString().padLeft(3, '0');
  }

  InvoiceModel createInvoiceModel() {
    final box = Hive.box<InvoiceModel>(HiveBoxNames.invoices);
    final int newId = (box.isEmpty)
        ? 0
        : box.keys
                .cast<int>()
                .reduce((value, element) => value > element ? value : element) +
            1;

    return InvoiceModel(
        id: newId,
        client:
            Provider.of<ClientProvider>(context, listen: false).selectedClient!,
        issueDate: DateTime.now(),
        dueDate: dueDate.toDateTime(),
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

  Future<void> fetchInvoices() async {
    _isLoading = true;
    notifyListeners();

    try {
      _invoices = await _invoiceRepo.getAllInvoices();
    } catch (e) {
      _state = AppUIStates.empty;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addInvoice(InvoiceModel invoice) async {
    try {
      await _invoiceRepo.saveInvoice(invoice);
      _invoices.add(invoice);
      notifyListeners();
    } catch (e) {
      _state = AppUIStates.empty;
      notifyListeners();
    }
  }

  Future<void> updateInvoice(InvoiceModel invoice) async {
    try {
      await _invoiceRepo.updateInvoice(invoice);
      int index = _invoices.indexWhere((i) => i.id == invoice.id);
      if (index != -1) {
        _invoices[index] = invoice;
        notifyListeners();
      }
    } catch (e) {
      _state = AppUIStates.empty;
      notifyListeners();
    }
  }

  Future<void> updateInvoiceAmount(
      InvoiceModel invoice, double newPaidAmount) async {
    try {
      await _invoiceRepo.updateInvoiceAmount(invoice, newPaidAmount);
      notifyListeners();
    } catch (e) {
      _state = AppUIStates.empty;
      notifyListeners();
    }
  }

  void clearDueDate() {
    _dueDate = "-";
    notifyListeners();
  }

  Future<void> deleteInvoice(int id) async {
    try {
      await _invoiceRepo.deleteInvoice(id);
      _invoices.removeWhere((invoice) => invoice.id == id);
      notifyListeners();
    } catch (e) {
      _state = AppUIStates.empty;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    taxController.removeListener(_handleTaxInputChange);
    taxController.removeListener(_updateFormattedTaxText);
    taxController.dispose();
    super.dispose();
  }
}
