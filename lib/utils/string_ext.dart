import 'package:intl/intl.dart';

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

  String? toDateFormat({String? format = 'dd MMMM yyyy', String? locale}) {
    final String? value = this;
    if (value == null || value.isEmpty) return value;
    final DateTime dateTime = DateTime.parse(value);
    final DateFormat dateFormat = DateFormat(format, locale);
    return dateFormat.format(dateTime);
  }

  String countryCodeToEmoji() {
    String? countryCode = this;
    if (countryCode == null) return '';
    if (countryCode == 'en') {
      countryCode = 'US';
    }
    // 0x41 is Letter A
    // 0x1F1E6 is Regional Indicator Symbol Letter A
    // Example :
    // firstLetter U => 20 + 0x1F1E6
    // secondLetter S => 18 + 0x1F1E6
    // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
    final int firstLetter =
        countryCode.toUpperCase().codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter =
        countryCode.toUpperCase().codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  String get countryName => switch (this) {
    'en' => 'English',
    'id' => 'Indonesia',
    _ => '-',
  };

  String whenEmpty({String defaultValue = ''}) {
    final String? value = this;
    return value == null || value.isEmpty ? defaultValue : value;
  }
}
