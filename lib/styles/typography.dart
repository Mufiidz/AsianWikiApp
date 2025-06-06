import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/export_utils.dart';

TextTheme createTextTheme(
  BuildContext context, {
  String displayFontString = 'Montserrat',
  String bodyFontString = 'Poppins',
}) {
  TextTheme baseTextTheme = context.textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
    bodyFontString,
    baseTextTheme,
  );
  TextTheme displayTextTheme = GoogleFonts.getTextTheme(
    displayFontString,
    baseTextTheme,
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
