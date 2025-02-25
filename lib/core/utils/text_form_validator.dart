import '../constants/app_strings.dart';

class TextFormValidator {
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
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
      return "Email is required";
    }
    String pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Field is Required";
    }

    return null;
  }
}
