import 'package:flutter/material.dart';

abstract class CornerRadius {
  CornerRadius._();

  /// Border radius (8)
  static const double small = 8.0;

  /// Border radius (16)
  static const double medium = 16.0;

  /// Border radius (24)
  static const double large = 24.0;

  /// Border radius circular (8)
  ///
  /// BorderRadius.circular(8);
  static BorderRadius smallRadius = BorderRadius.circular(small);

  /// Border radius circular (16)
  ///
  /// BorderRadius.circular(16);
  static BorderRadius mediumRadius = BorderRadius.circular(medium);

  /// Border radius circular (24)
  ///
  /// BorderRadius.circular(24);
  static BorderRadius largeRadius = BorderRadius.circular(large);
}
