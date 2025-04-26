import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'export_utils.dart';

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
    bodyFontString,
    context.textTheme,
  );
  TextTheme displayTextTheme = GoogleFonts.getTextTheme(
    displayFontString,
    context.textTheme,
  );
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}

Color getRandomDarkColor() {
  final Random random = Random();

  // Keep RGB values low for a dark color (0 to 100 for each channel)
  int red = random.nextInt(100);
  int green = random.nextInt(100);
  int blue = random.nextInt(100);

  return Color.fromARGB(255, red, green, blue);
}