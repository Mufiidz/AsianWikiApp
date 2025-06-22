import 'package:flutter/material.dart';

import '../styles/export_styles.dart';
import '../widgets/read_more_modal.dart';
import '../widgets/shimmer.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  bool get isDark => theme.brightness == Brightness.dark;
  Size get mediaSize => MediaQuery.of(this).size;
  ScaffoldMessengerState get snackbar => ScaffoldMessenger.of(this);
  MaterialTheme get materialTheme => MaterialTheme(this);
  double get heightWithToolbar => mediaSize.height - kToolbarHeight;
  ShimmerState? get shimmer => Shimmer.of(this);
  TextTheme get appTextTheme =>
      createTextTheme(this, displayFontString: 'Poppins');
  void showReadMoreModal(List<String>? contents, String title) =>
      readMoreModal(this, contents, title);
}
