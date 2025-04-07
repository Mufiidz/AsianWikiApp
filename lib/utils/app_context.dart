import 'package:flutter/material.dart';

import '../res/theme.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  Size get mediaSize => MediaQuery.of(this).size;
  ScaffoldMessengerState get snackbar => ScaffoldMessenger.of(this);
  MaterialTheme get materialTheme => MaterialTheme(this);
}
