import 'dart:math';

import 'package:flutter/material.dart';

Color getRandomDarkColor() {
  final Random random = Random();

  // Keep RGB values low for a dark color (0 to 100 for each channel)
  int red = random.nextInt(100);
  int green = random.nextInt(100);
  int blue = random.nextInt(100);

  return Color.fromARGB(255, red, green, blue);
}