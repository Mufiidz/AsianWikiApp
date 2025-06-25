import 'package:flutter/material.dart';

abstract class Spacing {
  Spacing._();

  /// Small Spacing with space 8
  static const double small = 8.0;

  /// Medium Spacing with space 16
  static const double medium = 16.0;

  /// Large Spacing with space 32
  static const double large = 32.0;

  /// Small Spacing
  ///
  /// SizedBox(height: 8)
  static const SizedBox smallSpacing = SizedBox(height: small);

  /// Medium Spacing
  ///
  /// SizedBox(height: 16)
  static const SizedBox mediumSpacing = SizedBox(height: medium);

  /// Medium Spacing
  ///
  /// SizedBox(height: 16)
  static const SizedBox mediumHSpacing = SizedBox(width: medium);

  /// Spacing with height 24
  ///
  /// SizedBox(height: 24)
  static const SizedBox spacing24 = SizedBox(height: 24);

  /// Horizontal Small Spacing
  ///
  /// SizedBox(width: 8)
  static const SizedBox hSmallSpacing = SizedBox(width: small);

  /// Horizontal Medium Spacing
  ///
  /// SizedBox(width: 16)
  static const SizedBox hMediumSpacing = SizedBox(width: medium);
}
