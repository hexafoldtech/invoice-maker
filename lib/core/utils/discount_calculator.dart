import 'package:provider/provider.dart';
import '../../providers/item_provider.dart';
import '../constants/global_key.dart';
import '../constants/app_strings.dart';

class AddItemUtils {
  double calcTotalPrice() {
    final itemsProvider =
        Provider.of<ItemProvider>(navigatorKey.currentContext!, listen: false);

    var unitPrice = double.parse(itemsProvider.moneyController.text);
    var quantity = double.parse(itemsProvider.quantityController.text);

    var totalPrice = unitPrice * quantity;
    return totalPrice;
  }

  double calcDiscountRate() {
    final itemsProvider =
        Provider.of<ItemProvider>(navigatorKey.currentContext!, listen: false);

    var discountText = itemsProvider.discountController.text.trim();
    var discount = discountText.isEmpty ? 0.0 : double.parse(discountText);

    var totalPrice = calcTotalPrice();

    double discountRate;
    if (itemsProvider.selectedDiscountType
        .contains(AppStrings.rupeeSymbolText)) {
      discountRate =
          double.parse(((discount * 100) / totalPrice).toStringAsFixed(2));
    } else {
      discountRate = discount;
    }

    return discountRate;
  }

  double calcDiscount() {
    final itemsProvider =
        Provider.of<ItemProvider>(navigatorKey.currentContext!, listen: false);
    var totalPrice = calcTotalPrice();

    var discountText = itemsProvider.discountController.text.trim();
    var discountRate = discountText.isEmpty ? 0.0 : double.parse(discountText);

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
    final itemsProvider =
        Provider.of<ItemProvider>(navigatorKey.currentContext!, listen: false);

    var totalPrice = calcTotalPrice();

    var discountText = itemsProvider.discountController.text.trim();
    var discount = discountText.isEmpty ? 0.0 : double.parse(discountText);

    double discountedPrice;

    if (itemsProvider.selectedDiscountType
        .contains(AppStrings.percentSymbolText)) {
      discountedPrice = double.parse(
          (totalPrice - (totalPrice * (discount / 100))).toStringAsFixed(2));
    } else {
      discountedPrice =
          double.parse((totalPrice - discount).toStringAsFixed(2));
    }

    return discountedPrice;
  }
}
