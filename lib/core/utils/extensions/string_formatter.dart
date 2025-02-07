extension StringFormatter on String {
  String formatString({bool capitalizeWords = false}) {
    // Replace special characters with space
    String formatted = replaceAll(RegExp(r'[^a-zA-Z0-9]'), ' ');

    // Add space between camelCase words
    formatted = formatted.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)} ${match.group(2)}',
    );

    // Convert to lowercase first to ensure consistent capitalization
    formatted = formatted.toLowerCase();

    if (capitalizeWords) {
      // Capitalize each word
      formatted = formatted
          .split(' ')
          .map((word) => word.isNotEmpty
              ? word[0].toUpperCase() + word.substring(1)
              : '')
          .join(' ');
    } else {
      // Capitalize only the first letter
      formatted = formatted.isNotEmpty
          ? formatted[0].toUpperCase() + formatted.substring(1)
          : '';
    }

    return formatted.trim();
  }
}
