import 'package:flutter/material.dart';

abstract class PaddingStyle {
  PaddingStyle._();

  /// Padding for small (8)
  static const double small = 8.0;

  /// Padding for medium (16)
  static const double medium = 16.0;

  /// Padding for large (32)
  static const double large = 32.0;

  /// Padding for medium (horizontal: 16)
  static const EdgeInsets mediumHorizontal = EdgeInsets.symmetric(
    horizontal: medium,
  );

  /// Padding for screen (horizontal: 16, vertical: 8)
  static const EdgeInsets screen = EdgeInsets.symmetric(
    horizontal: medium,
    vertical: small,
  );

  /// Padding for screen (horizontal: 16, vertical: 8)
  static const EdgeInsets paddingH16V8 = EdgeInsets.symmetric(
    horizontal: medium,
    vertical: small,
  );

  static const EdgeInsets paddingH8V16 = EdgeInsets.symmetric(
    horizontal: small,
    vertical: medium,
  );

  /// Padding for medium (bottom: 16)
  static const EdgeInsets onlyBottomM = EdgeInsets.only(bottom: medium);
}
