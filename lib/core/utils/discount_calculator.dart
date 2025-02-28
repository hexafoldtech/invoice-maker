import 'package:flutter/widgets.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/providers/item_provider.dart';
import 'package:provider/provider.dart';

class AddItemUtils {
  final BuildContext context;

  AddItemUtils({required this.context});

  double calcTotalPrice() {
    final itemsProvider = Provider.of<ItemProvider>(context, listen: false);

    var unitPrice = double.parse(itemsProvider.moneyController.text);
    var quantity = double.parse(itemsProvider.quantityController.text);

    var totalPrice = unitPrice * quantity;
    return totalPrice;
  }

  double calcDiscount() {
    final itemsProvider = Provider.of<ItemProvider>(context, listen: false);
    var totalPrice = calcTotalPrice();
    var discountRate = double.parse(itemsProvider.discountController.text);
    double discount;

    if (itemsProvider.selectedDiscountType
        .contains(AppStrings.percentSymbolText)) {
      discount =
          double.parse((totalPrice * (discountRate / 100)).toStringAsFixed(2));
    } else {
      discount = discountRate;
    }

    return discount;
  }

  double calcDiscountedPrice() {
    final itemsProvider = Provider.of<ItemProvider>(context, listen: false);

    var totalPrice = calcTotalPrice();

    var discount = double.parse(itemsProvider.discountController.text);
    double disCountedPrice;
    if (itemsProvider.selectedDiscountType
        .contains(AppStrings.percentSymbolText)) {
      disCountedPrice = double.parse(
          (totalPrice - (totalPrice * (discount / 100))).toStringAsFixed(2));
    } else {
      disCountedPrice =
          double.parse((totalPrice - discount).toStringAsFixed(2));
    }

    return disCountedPrice;
  }
}
