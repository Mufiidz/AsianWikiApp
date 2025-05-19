extension StringExt on String? {
  String get cleanedText =>
      (this ?? '').trim().replaceAll(RegExp(r'\s+\b|\b\s'), ' ');

  /// Capitalizes the letter of the string
  String? capitalize() {
    final String? value = this;
    if (value == null || value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  /// Capitalizes the first letter of the string
  String? capitalizeFirst() {
    final String? value = this;
    if (value == null || value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  /// Capitalizes the first letter of each word in the string
  String? toTitleCase() {
    final String? value = this;
    if (value == null || value.isEmpty) return value;
    return value
        .split(' ')
        .map((String word) => word.capitalizeFirst())
        .join(' ');
  }

  bool isValidUrl() {
    final String? value = this;
    if (value == null || value.isEmpty) return false;
    final Uri? uri = Uri.tryParse(value);
    return uri != null && (uri.hasScheme && uri.hasAuthority);
  }
}
