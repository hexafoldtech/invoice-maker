import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:invoice_maker/core/constants/hive_box_names.dart';
import 'package:invoice_maker/core/utils/discount_calculator.dart';
import '../core/constants/app_strings.dart';
import '../models/ItemModel/items_model.dart';
import '../repository/items_repo.dart';

enum AppUIStates { loading, empty, success, none }

class ItemProvider extends ChangeNotifier {
  final ItemRepo _itemRepo = ItemRepo();
  List<ItemsModel> _items = [];
  List<ItemsModel> _selectedItems = [];
  AppUIStates _state = AppUIStates.empty;

  List<ItemsModel> get items => _items;
  List<ItemsModel> get selectedItems => _selectedItems;
  AppUIStates get state => _state;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _quantityController =
      TextEditingController(text: '1');

  TextEditingController get nameController => _nameController;
  TextEditingController get detailsController => _detailsController;
  TextEditingController get discountController => _discountController;
  TextEditingController get moneyController => _moneyController;
  TextEditingController get quantityController => _quantityController;

  bool _saveToItems = true;
  bool _isDiscountEnabled = false;
  bool _isTaxable = false;
  bool _showDiscountTypeRow = false;

  bool get saveToItems => _saveToItems;
  bool get isDiscountEnabled => _isDiscountEnabled;
  bool get isTaxable => _isTaxable;
  bool get showDiscountTypeRow => _showDiscountTypeRow;

  /// Default unit type selection
  String _unitType = AppStrings.optionalText;
  String get unitType => _unitType;

  final List<MapEntry<String, String>> _unitTypeOptions = [
    const MapEntry(AppStrings.noneText, AppStrings.noneText),
    const MapEntry(AppStrings.hoursText, AppStrings.hoursText),
    const MapEntry(AppStrings.daysText, AppStrings.daysText),
    const MapEntry(AppStrings.cancelText,
        AppStrings.cancelText), // Used to close the bottom sheet
  ];
  List<MapEntry<String, String>> get unitTypeOptions => _unitTypeOptions;

  /// Selected discount type
  String _selectedDiscountType = AppStrings.percentSymbolText;
  String get selectedDiscountType => _selectedDiscountType;

  double _discount = 0;
  double get discount => _discount;

  double _discountedPrice = 0;
  double get discountPrice => _discountedPrice;

  /// Update the selected unit type
  void updateUnitType(String newUnitType) {
    _unitType = newUnitType;
    notifyListeners();
  }

  /// Update the selected discount type
  void updateDiscountType(String newDiscountType) {
    _selectedDiscountType = newDiscountType;
    notifyListeners();
  }

  void calculateDiscount(BuildContext context) {
    if (_discountController.text.isNotEmpty) {
      _discount = AddItemUtils().calcDiscount();
      _discountedPrice = AddItemUtils().calcDiscountedPrice();
      notifyListeners();
    }
  }

  /// Toggle discount switch visibility based on input
  void toggleDiscountSwitchVisibility(bool value) {
    _isDiscountEnabled = value;
    _showDiscountTypeRow = value;
    notifyListeners();
  }

  void toggleDiscountRow(bool value) {
    _showDiscountTypeRow = value;
    notifyListeners();
  }

  /// Toggle save to item catalog
  void toggleSaveSwitchVisibility(bool value) {
    _saveToItems = value;
    notifyListeners();
  }

  void toggleTaxSwitchVisibility(bool value) {
    _isTaxable = value;
    notifyListeners();
  }

  void clearForm() {
    _nameController.clear();
    _detailsController.clear();
    _discountController.clear();
    _moneyController.clear();
    _quantityController.clear();
    _saveToItems = true;
    _isDiscountEnabled = false;
    _isTaxable = false;
    _showDiscountTypeRow = false;
    notifyListeners();
  }

  void clearSelectedItems() {
    _selectedItems = [];
    notifyListeners();
  }

  ItemsModel createItemModel() {
    final box = Hive.box<ItemsModel>(HiveBoxNames.items);
    final int newId = (box.isEmpty)
        ? 0
        : box.keys
                .cast<int>()
                .reduce((value, element) => value > element ? value : element) +
            1;
    var totalPrice = AddItemUtils().calcTotalPrice();
    var discount = AddItemUtils().calcDiscount();
    var discountRate = AddItemUtils().calcDiscountRate();
    return ItemsModel(
        id: newId,
        itemName: _nameController.text,
        itemDetails: _detailsController.text,
        isDiscount: _isDiscountEnabled,
        itemQuantity: int.parse(_quantityController.text),
        itemUnitPrice: double.parse(_moneyController.text),
        itemDiscount: _isDiscountEnabled ? discount : null,
        itemDiscountRate: discountRate,
        itemTaxable: _isTaxable,
        totalItemPrice: totalPrice,
        itemPrice: _isDiscountEnabled ? _discountedPrice : totalPrice,
        unitType: unitType != AppStrings.optionalText ? unitType : null);
  }

  /// Fetch all items from the repository
  Future<void> fetchAllItems() async {
    _state = AppUIStates.loading;
    notifyListeners();
    try {
      final items = await _itemRepo.getAllItems();
      _items = items;
      _state = _items.isEmpty ? AppUIStates.empty : AppUIStates.success;
      notifyListeners();
    } catch (e) {
      _state = AppUIStates.empty;
    }
  }

  void selectItems(ItemsModel item) {
    _selectedItems.add(item);
    notifyListeners();
  }

  void deleteSelectedItem(ItemsModel item) {
    _selectedItems.remove(item);
    notifyListeners();
  }

  /// Add a new item to the list
  Future<void> addItem(ItemsModel item) async {
    await _itemRepo.saveItem(item);
    _items.add(item);
    notifyListeners();
  }

  /// Get an item by ID
  ItemsModel? getItemById(int id) {
    try {
      return _items.firstWhere((client) => client.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Delete an item by ID
  Future<void> deleteItem(int id) async {
    await _itemRepo.deleteItem(id);
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  /// Dispose controllers to avoid memory leaks
  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    _discountController.dispose();
    _moneyController.dispose();
    super.dispose();
  }
}
