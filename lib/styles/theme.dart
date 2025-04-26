import 'package:flutter/material.dart';

import '../utils/export_utils.dart';

class MaterialTheme {
  final BuildContext context;

  const MaterialTheme(this.context);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006a69),
      surfaceTint: Color(0xff006a69),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9cf1ef),
      onPrimaryContainer: Color(0xff00504f),
      secondary: Color(0xff6f528a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfff0dbff),
      onSecondaryContainer: Color(0xff563a70),
      tertiary: Color(0xff626118),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe9e78f),
      onTertiaryContainer: Color(0xff4a4900),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff4fbfa),
      onSurface: Color(0xff161d1d),
      onSurfaceVariant: Color(0xff3f4948),
      outline: Color(0xff6f7978),
      outlineVariant: Color(0xffbec9c8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff80d5d3),
      primaryFixed: Color(0xff9cf1ef),
      onPrimaryFixed: Color(0xff002020),
      primaryFixedDim: Color(0xff80d5d3),
      onPrimaryFixedVariant: Color(0xff00504f),
      secondaryFixed: Color(0xfff0dbff),
      onSecondaryFixed: Color(0xff280d42),
      secondaryFixedDim: Color(0xffdbb9f9),
      onSecondaryFixedVariant: Color(0xff563a70),
      tertiaryFixed: Color(0xffe9e78f),
      onTertiaryFixed: Color(0xff1d1d00),
      tertiaryFixedDim: Color(0xffcccb76),
      onTertiaryFixedVariant: Color(0xff4a4900),
      surfaceDim: Color(0xffd5dbda),
      surfaceBright: Color(0xfff4fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f4),
      surfaceContainer: Color(0xffe9efee),
      surfaceContainerHigh: Color(0xffe3e9e8),
      surfaceContainerHighest: Color(0xffdde4e3),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003d3d),
      surfaceTint: Color(0xff006a69),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff167978),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff452a5e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff7e619a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff393800),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff717026),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbfa),
      onSurface: Color(0xff0c1212),
      onSurfaceVariant: Color(0xff2e3838),
      outline: Color(0xff4a5454),
      outlineVariant: Color(0xff656f6e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff80d5d3),
      primaryFixed: Color(0xff167978),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005f5e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff7e619a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff65497f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff717026),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff58570d),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc1c8c7),
      surfaceBright: Color(0xfff4fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f4),
      surfaceContainer: Color(0xffe3e9e8),
      surfaceContainerHigh: Color(0xffd8dedd),
      surfaceContainerHighest: Color(0xffccd3d2),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003232),
      surfaceTint: Color(0xff006a69),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff005252),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3a1f54),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff593d73),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2e2e00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4c4c01),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbfa),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff242e2e),
      outlineVariant: Color(0xff414b4b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff80d5d3),
      primaryFixed: Color(0xff005252),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003939),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff593d73),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff41265b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4c4c01),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff353400),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb4bab9),
      surfaceBright: Color(0xfff4fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffecf2f1),
      surfaceContainer: Color(0xffdde4e3),
      surfaceContainerHigh: Color(0xffcfd6d5),
      surfaceContainerHighest: Color(0xffc1c8c7),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff80d5d3),
      surfaceTint: Color(0xff80d5d3),
      onPrimary: Color(0xff003736),
      primaryContainer: Color(0xff00504f),
      onPrimaryContainer: Color(0xff9cf1ef),
      secondary: Color(0xffdbb9f9),
      onSecondary: Color(0xff3f2458),
      secondaryContainer: Color(0xff563a70),
      onSecondaryContainer: Color(0xfff0dbff),
      tertiary: Color(0xffcccb76),
      onTertiary: Color(0xff333200),
      tertiaryContainer: Color(0xff4a4900),
      onTertiaryContainer: Color(0xffe9e78f),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffdde4e3),
      onSurfaceVariant: Color(0xffbec9c8),
      outline: Color(0xff889392),
      outlineVariant: Color(0xff3f4948),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e3),
      inversePrimary: Color(0xff006a69),
      primaryFixed: Color(0xff9cf1ef),
      onPrimaryFixed: Color(0xff002020),
      primaryFixedDim: Color(0xff80d5d3),
      onPrimaryFixedVariant: Color(0xff00504f),
      secondaryFixed: Color(0xfff0dbff),
      onSecondaryFixed: Color(0xff280d42),
      secondaryFixedDim: Color(0xffdbb9f9),
      onSecondaryFixedVariant: Color(0xff563a70),
      tertiaryFixed: Color(0xffe9e78f),
      onTertiaryFixed: Color(0xff1d1d00),
      tertiaryFixedDim: Color(0xffcccb76),
      onTertiaryFixedVariant: Color(0xff4a4900),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1d),
      surfaceContainer: Color(0xff1a2121),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff2f3636),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff96ebe9),
      surfaceTint: Color(0xff80d5d3),
      onPrimary: Color(0xff002b2b),
      primaryContainer: Color(0xff479e9d),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffecd3ff),
      onSecondary: Color(0xff33184d),
      secondaryContainer: Color(0xffa384c0),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffe2e189),
      onTertiary: Color(0xff272700),
      tertiaryContainer: Color(0xff959446),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd4dedd),
      outline: Color(0xffaab4b3),
      outlineVariant: Color(0xff889292),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e3),
      inversePrimary: Color(0xff005150),
      primaryFixed: Color(0xff9cf1ef),
      onPrimaryFixed: Color(0xff001414),
      primaryFixedDim: Color(0xff80d5d3),
      onPrimaryFixedVariant: Color(0xff003d3d),
      secondaryFixed: Color(0xfff0dbff),
      onSecondaryFixed: Color(0xff1d0137),
      secondaryFixedDim: Color(0xffdbb9f9),
      onSecondaryFixedVariant: Color(0xff452a5e),
      tertiaryFixed: Color(0xffe9e78f),
      onTertiaryFixed: Color(0xff121200),
      tertiaryFixedDim: Color(0xffcccb76),
      onTertiaryFixedVariant: Color(0xff393800),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff3f4645),
      surfaceContainerLowest: Color(0xff040808),
      surfaceContainerLow: Color(0xff181f1f),
      surfaceContainer: Color(0xff232929),
      surfaceContainerHigh: Color(0xff2d3433),
      surfaceContainerHighest: Color(0xff383f3f),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffaafffd),
      surfaceTint: Color(0xff80d5d3),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff7cd1cf),
      onPrimaryContainer: Color(0xff000e0e),
      secondary: Color(0xfff9ebff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffd7b5f4),
      onSecondaryContainer: Color(0xff15002b),
      tertiary: Color(0xfff6f49b),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc8c772),
      onTertiaryContainer: Color(0xff0c0c00),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe8f2f1),
      outlineVariant: Color(0xffbac5c4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e3),
      inversePrimary: Color(0xff005150),
      primaryFixed: Color(0xff9cf1ef),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff80d5d3),
      onPrimaryFixedVariant: Color(0xff001414),
      secondaryFixed: Color(0xfff0dbff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffdbb9f9),
      onSecondaryFixedVariant: Color(0xff1d0137),
      tertiaryFixed: Color(0xffe9e78f),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffcccb76),
      onTertiaryFixedVariant: Color(0xff121200),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff4b5151),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1a2121),
      surfaceContainer: Color(0xff2b3231),
      surfaceContainerHigh: Color(0xff363d3c),
      surfaceContainerHighest: Color(0xff414848),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) {
    final TextTheme textTheme = createTextTheme(context, 'Roboto', 'Poppins');
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
    );
  }

  List<ExtendedColor> get extendedColors => <ExtendedColor>[];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
