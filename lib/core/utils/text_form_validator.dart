import '../constants/app_strings.dart';

class TextFormValidator {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.enterRequiredNameText;
    }

    // Regex: Allows alphabets, spaces, and dots (for initials like "J.K. Rowling")
    String pattern = r"^[a-zA-Z\s.]{2,50}$";
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value.trim())) {
      return AppStrings.enterValidNameText;
    }

    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.enterRequiredAddressText;
    }

    // Address validation (allows alphabets, numbers, commas, periods, hyphens, and spaces)
    String pattern = r"^[a-zA-Z0-9\s,.-]{5,100}$";
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value.trim())) {
      return AppStrings.enterValidAddressText;
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.enterRequiredPhoneNumberText;
    }
    // regex pattern for Indian phone numbers (starting with 6-9, 10 digits)
    String pattern = r"^(\+91[\s]?)?[6-9]\d{9}$";
    RegExp regExp = RegExp(pattern);
    final bool isValidPhoneNumber = regExp.hasMatch(value);
    if (!isValidPhoneNumber) {
      return AppStrings.enterValidPhoneNumberText;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.enterRequiredEmailText;
    }
    String pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return AppStrings.enterValidEmailText;
    }
    return null;
  }

  static String? validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.enterRequiredPriceText;
    }

    // Allow positive decimal values (e.g., 10.50, 999, 0.99)
    String pattern = r"^\d+(\.\d{1,2})?$";
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value.trim())) {
      return AppStrings.enterValidPriceText;
    }

    double price = double.tryParse(value) ?? 0;
    if (price <= 0) {
      return AppStrings.enterGreaterPriceText;
    }

    return null;
  }

  static String? validateQuantity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.enterRequiredQuantityText;
    }

    // Allow only whole numbers (positive integers)
    String pattern = r"^[1-9]\d*$";
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value.trim())) {
      return AppStrings.enterValidQuantityText;
    }

    return null;
  }

  static String? validateDiscount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Discount is optional
    }

    // Allow numbers with up to 2 decimal places (e.g., 5, 10.5, 50.00)
    String pattern = r"^\d+(\.\d{1,2})?$";
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value.trim())) {
      return AppStrings.enterValidDiscountText;
    }

    double discount = double.tryParse(value) ?? 0;
    if (discount < 0) {
      return AppStrings.enterGreaterDiscountText;
    }

    return null;
  }

  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.enterRequiredFieldText;
    }

    return null;
  }
}
